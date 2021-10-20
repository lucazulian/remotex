defmodule RemotexWeb.Controllers.RandomUsers do
  @moduledoc false

  require Logger

  use Phoenix.Controller, namespace: RemotexWeb

  import Plug.Conn

  @doc """
  Returns, at max 2 (it can return less), users with more than a random number of points
  """
  def get(conn, _params) do
    send_resp(conn, 200, "ok")
  end
end
