defmodule Remotex.Core.Behaviours.UsersQueryBulk do
  @moduledoc false

  @behaviour Remotex.Core.Behaviours.UsersQueryBulkBehaviour

  alias Remotex.Core.Values.EngineState
  alias Remotex.Core.Values.UsersQueryResult

  @impl true
  def update do
    {:ok, :test}
  end

  @impl true
  def fetch(%EngineState{max_number: 0}), do: {:ok, %UsersQueryResult{}}
  def fetch(_), do: {:error, :number_too_high}
end
