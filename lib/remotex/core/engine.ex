defmodule Remotex.Core.Engine do
  @moduledoc false

  use GenServer

  require Logger

  defstruct [:max_number, :queried_at]

  @random_range 0..100 |> Enum.to_list()
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

    {:ok, %__MODULE__{max_number: Enum.random(@random_range), queried_at: nil}}
  end

  @impl GenServer
  def handle_info(:tick, state) do
    Task.Supervisor.start_child(
      Remotex.TaskSupervisor,
      fn -> @users_strategy_module.update() end
    )

    {:noreply, %__MODULE__{state | max_number: Enum.random(@random_range)}}
  end

  @impl GenServer
  def handle_call(:query_users, _from, state) do
    response =
      case @users_strategy_module.fetch(state.max_number) do
        {:ok, users} ->
          {:ok, %{users: users, queried_at: state.queried_at}}

        {:error, _} = error ->
          error
      end

    {:reply, response, %__MODULE__{state | queried_at: DateTime.utc_now()}}
  end
end
