defmodule Remotex.Core.Behaviours.UsersQueryBulkBehaviour do
  @moduledoc false

  alias Remotex.Core.Schemas.User

  @callback update() :: {:ok, term()} | {:error, term()}
  @callback fetch(max_number :: integer()) :: {:ok, list(User.t())} | {:error, term()}
end
