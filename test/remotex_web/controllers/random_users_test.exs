defmodule RemotexWeb.Controllers.RandomUsersTest do
  @moduledoc false

  use Plug.Test
  use RemotexWeb.ConnCase, async: true

  import Mock

  alias RemotexWeb.Controllers.RandomUsers

  describe "get/2" do
    test "It should returns 200 with valid response body when calling / endpoint" do
      with_mock Remotex.Core.Engine, query_users: fn -> {:ok, %{users: [], queried_at: nil}} end do
        conn = conn(:get, "/", %{})
        response = RandomUsers.get(conn, %{})

        assert response.status == 200
        assert response.resp_body == "{\"queried_at\":null,\"users\":[]}"
      end
    end

    test "It should returns 500 with valid reason when calling / endpoint" do
      with_mock Remotex.Core.Engine, query_users: fn -> {:error, :a_very_specific_reason} end do
        conn = conn(:get, "/", %{})
        response = RandomUsers.get(conn, %{})

        assert response.status == 500
        assert response.resp_body == "\"a_very_specific_reason\""
      end
    end
  end
end
