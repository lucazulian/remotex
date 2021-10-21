defmodule Remotex.Core.Engine do
  @moduledoc false

  use GenServer

  require Logger

  alias Remotex.Core.Values.EngineState
  alias Remotex.Core.Values.UsersQueryResult

  @users_strategy_module Application.compile_env(:remotex, :users_strategy_module)

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
    interval = Keyword.get(opts, :interval, 10_000)

    case mode do
      :periodic ->
        :timer.send_interval(interval, self(), :tick)
        start_async_task()

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
    {:reply, @users_strategy_module.fetch(state), EngineState.new_queried_at(state)}
  end

  defp start_async_task() do
    Task.Supervisor.start_child(
      Remotex.TaskSupervisor,
      fn -> @users_strategy_module.update() end
    )
  end
end
