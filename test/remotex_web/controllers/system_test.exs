defmodule RemotexWeb.Controllers.SystemTest do
  @moduledoc false

  use Plug.Test
  use RemotexWeb.ConnCase, async: true

  alias RemotexWeb.Controllers.System

  describe "not_found/2" do
    test "It should returns 400 with a non not existing /hello-there endpoint" do
      conn = conn(:get, "/hello-there", %{})
      response = System.not_found(conn, %{})

      assert response.status == 404
      assert response.resp_body == ""
    end
  end
end
