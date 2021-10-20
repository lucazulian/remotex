defmodule Remotex.Core.Behaviours.NoOpUsersQueryBulk do
  @moduledoc false

  @behaviour Remotex.Core.Behaviours.UsersQueryBulkBehaviour

  @impl true
  def update do
    {:ok, :test}
  end

  @impl true
  def fetch(_max_number) do
    {:ok, []}
  end
end
