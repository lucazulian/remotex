defmodule RemotexWeb.Controllers.System do
  @moduledoc false

  use Phoenix.Controller, namespace: RemotexWeb

  def not_found(conn, _params) do
    send_resp(conn, 404, "")
  end
end
