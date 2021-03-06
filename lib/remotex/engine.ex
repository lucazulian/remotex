defmodule Remotex.Engine do
  @moduledoc false

  use GenServer

  require Logger

  alias Remotex.UserOperations
  alias Remotex.Values.EngineState
  alias Remotex.Values.UsersQueryResult

  @spec query_users :: {:ok, UsersQueryResult.t()} | {:error, term()}
  def query_users do
    GenServer.call(__MODULE__, :query_users)
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl GenServer
  def init(opts) do
    mode = Keyword.get(opts, :mode, :periodic)
    interval = Keyword.get(opts, :interval, 60_000)

    case mode do
      :periodic ->
        :timer.send_interval(interval, self(), :tick)

      :manual ->
        :ok
    end

    {:ok, EngineState.init()}
  end

  @impl GenServer
  def handle_info(:tick, state) do
    Logger.debug(fn -> "Start periodic tick" end)

    start_async_task()

    {:noreply, EngineState.new_random(state)}
  end

  @impl GenServer
  def handle_call(:query_users, _from, state) do
    {:reply, UserOperations.fetch(state), EngineState.new_queried_at(state)}
  end

  defp start_async_task do
    Task.Supervisor.start_child(Remotex.TaskSupervisor, fn -> UserOperations.update() end)
  end
end
