defmodule RemotexWeb.Controllers.RandomUsers do
  @moduledoc false

  require Logger

  use Phoenix.Controller, namespace: RemotexWeb

  import Plug.Conn

  alias Remotex.Core.Engine

  @doc """
  Returns, at max 2 (it can return less), users with more than a random number of points
  """
  def get(conn, _params) do
    {status_code, body} =
      case Engine.query_users() do
        {:ok, response} -> {200, response}
        {:error, reason} -> {500, reason}
      end

    send_resp(conn, status_code, Jason.encode!(body))
  end
end
