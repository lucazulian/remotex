defmodule Remotex.Core.Engine do
  @moduledoc false

  use GenServer

  require Logger

  alias Remotex.Core.Values.EngineState

  @users_strategy_module Application.compile_env(:remotex, :users_strategy_module)

  @spec query_users :: {:ok, map} | {:error, term()}
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
    Task.Supervisor.start_child(
      Remotex.TaskSupervisor,
      fn -> @users_strategy_module.update() end
    )

    {:noreply, EngineState.new_random(state)}
  end

  @impl GenServer
  def handle_call(:query_users, _from, state) do
    {:reply, @users_strategy_module.fetch(state), EngineState.new_queried_at(state)}
  end
end
