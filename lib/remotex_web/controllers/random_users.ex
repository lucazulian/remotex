defmodule RemotexWeb.Controllers.RandomUsers do
  @moduledoc false

  require Logger

  use Phoenix.Controller, namespace: RemotexWeb

  import Plug.Conn

  alias Remotex.Core.Engine
  alias RemotexWeb.Values.RandomUsersErrorResponse, as: Error
  alias RemotexWeb.Values.RandomUsersResponseParser, as: Parser

  @doc """
  Returns, at max 2 (it can return less), users with more than a random number of points
  """
  def get(conn, _params) do
    with {:ok, query_response} <- Engine.query_users(),
         random_users <- Parser.parse(query_response) do
      send_resp(conn, 200, Jason.encode!(random_users))
    else
      {:error, reason} ->
        Logger.error(fn -> "Get random users failed due to: " <> inspect(reason) end)

        send_resp(conn, 500, Jason.encode!(%Error{error: reason}))
    end
  end
end
