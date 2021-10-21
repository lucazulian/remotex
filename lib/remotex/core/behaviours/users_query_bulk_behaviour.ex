defmodule Remotex.Core.Behaviours.UsersQueryBulkBehaviour do
  @moduledoc false

  alias Remotex.Core.Values.EngineState
  alias Remotex.Core.Values.UsersQueryResult

  @callback update() :: :ok | {:error, term()}
  @callback fetch(state :: EngineState.t()) :: {:ok, UsersQueryResult.t()} | {:error, term()}
end
