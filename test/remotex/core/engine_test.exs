defmodule Remotex.Core.EngineTest do
  use ExUnit.Case, async: false

  import Mock

  describe "periodic action" do
    test "when the process \"ticks\", the UsersQueryBulk interface is called" do
      interval_in_ms = 5
      test_pid = self()
      ref = make_ref()

      start_options = [
        mode: :manual,
        interval: interval_in_ms
      ]

      pid = start_supervised!({Remotex.Core.Engine, start_options})
      _task_pid = start_supervised!({Task.Supervisor, name: Remotex.TaskSupervisor})

      with_mock Remotex.Core.Behaviours.NoOpUsersQueryBulk,
        update: fn ->
          send(test_pid, {:send_users_query_bulk_called, ref})
          :ok
        end do
        send(pid, :tick)

        assert_receive {:send_users_query_bulk_called, ^ref}
      end
    end
  end
end
