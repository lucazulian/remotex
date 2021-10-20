defmodule Remotex.Core.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl Supervisor
  def init(_init_arg) do
    children()
    |> Supervisor.init(strategy: :one_for_one)
  end

  defp children do
    [
      Remotex.Core.Engine,
      {Task.Supervisor, name: Remotex.TaskSupervisor}
    ]
  end
end
