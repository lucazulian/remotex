defmodule Remotex.Core.UserOperations do
  @moduledoc false

  import Ecto.Query

  require Logger

  alias Remotex.Core.Schemas.User
  alias Remotex.Core.Values.EngineState
  alias Remotex.Core.Values.UsersQueryResult
  alias Remotex.Repo

  def update do
    User
    |> update(set: [points: fragment("floor(RANDOM() * 100)")])
    |> Repo.update_all([])

    :ok
  rescue
    error ->
      Logger.error(fn -> "Update users failed due to: " <> inspect(error) end)

      {:error, :invalid_update_request}
  end

  def fetch(%EngineState{} = engine_state) do
    query =
      from u in User,
        where: u.points >= ^engine_state.max_number,
        order_by: fragment("RANDOM()"),
        limit: 2

    users = Repo.all(query)

    {:ok,
     %UsersQueryResult{
       users: users,
       queried_at: engine_state.queried_at
     }}
  rescue
    error ->
      Logger.error(fn -> "Fetch users failed due to: " <> inspect(error) end)

      {:error, :invalid_fetch_request}
  end
end
