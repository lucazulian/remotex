defmodule Remotex.Core.EngineTest do
  use ExUnit.Case, async: false

  import Mock

  alias Remotex.Core.Engine
  alias Remotex.Core.UserOperations
  alias Remotex.Core.Values.UsersQueryResult

  describe "Periodic action" do
    test "When the process \"ticks\", the update UsersQueryBulk interface is called" do
      test_pid = self()
      ref = make_ref()

      pid = start_supervised!({Engine, [mode: :manual]})
      _ = start_supervised!({Task.Supervisor, name: Remotex.TaskSupervisor})

      with_mock UserOperations,
        update: fn ->
          send(test_pid, {:send_users_update_bulk_called, ref})
          :ok
        end do
        send(pid, :tick)

        assert_receive {:send_users_update_bulk_called, ^ref}
      end
    end

    test "When query_users is called fetch UsersQueryBulk interface is called with last queried_at" do
      test_pid = self()
      ref = make_ref()

      users_query_result = %UsersQueryResult{
        users: [],
        queried_at: nil
      }

      _ = start_supervised!({Engine, [mode: :manual]})

      with_mock UserOperations,
        fetch: fn _ ->
          send(test_pid, {:send_users_fetch_called, ref})

          {:ok, users_query_result}
        end do
        {:ok, actual_users_query_result} = Engine.query_users()

        assert actual_users_query_result == users_query_result
        assert_receive {:send_users_fetch_called, ^ref}
      end
    end
  end
end
