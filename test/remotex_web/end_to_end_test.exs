defmodule RemotexWeb.EndToEndTest do
  @moduledoc false

  use Plug.Test
  use RemotexWeb.ConnCase, async: false

  import Mock

  alias Remotex.Engine
  alias Remotex.Repo
  alias Remotex.Schemas.User
  alias Remotex.Values.EngineState
  alias RemotexWeb.Controllers.RandomUsers

  @timestamp ~U[2021-10-21 10:47:08.067366Z]

  test "It should successfully start engine and call root entpoint" do
    setup_database_after_migration()

    pid = setup_engine()

    setup_engine_state(fn ->
      response = call_root_enpoint()

      assert response.status == 200
      assert response.resp_body == "{\"timestamp\":null,\"users\":[]}"

      manually_trigger_periodic_action(pid)

      response = call_root_enpoint()

      assert response.status == 200

      %{"timestamp" => timestamp, "users" => users} = Jason.decode!(response.resp_body)

      assert timestamp == DateTime.to_iso8601(@timestamp)
      assert Enum.count(users) == 2

      for %{points: points} <- users do
        assert points <= 100 && points >= 0,
               "Points #{points} did not match 0-100 range expectation"
      end
    end)
  end

  defp setup_database_after_migration do
    Repo.delete_all(User)
    for _ <- 1..3, do: Repo.insert(%User{points: 0})
  end

  defp setup_engine do
    start_supervised!({Task.Supervisor, name: Remotex.TaskSupervisor})
    start_supervised!({Engine, [mode: :manual]})
  end

  defp manually_trigger_periodic_action(pid) do
    send(pid, :tick)
    Process.sleep(50)
  end

  defp setup_engine_state(test_fn) do
    with_mock EngineState,
      new_random: fn engine_state ->
        %EngineState{engine_state | max_number: 0}
      end,
      new_queried_at: fn engine_state ->
        %EngineState{engine_state | queried_at: @timestamp}
      end do
      test_fn.()
    end
  end

  defp call_root_enpoint do
    conn = conn(:get, "/", %{})
    RandomUsers.get(conn, %{})
  end
end
