defmodule RemotexWeb.Controllers.RandomUsersTest do
  @moduledoc false

  use Plug.Test
  use RemotexWeb.ConnCase, async: true

  alias RemotexWeb.Controllers.RandomUsers

  describe "get/2" do
    test "It should returns 200 with valid response body when calling / endpoint" do
      conn = conn(:get, "/", %{})
      response = RandomUsers.get(conn, %{})

      assert response.status == 200
      assert response.resp_body == "ok"
    end
  end
end
