defmodule Remotex.Core.Behaviours.UsersQueryBulk do
  @moduledoc false

  @behaviour Remotex.Core.Behaviours.UsersQueryBulkBehaviour

  @impl true
  def update do
    {:ok, :test}
  end

  @impl true
  def fetch(0), do: {:ok, []}
  def fetch(_), do: {:error, :number_too_high}
end
