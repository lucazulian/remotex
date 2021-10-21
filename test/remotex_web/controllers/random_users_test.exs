defmodule RemotexWeb.Controllers.RandomUsersTest do
  @moduledoc false

  use Plug.Test
  use RemotexWeb.ConnCase, async: true

  import ExUnit.CaptureLog
  import Mock

  alias Remotex.Core.Values.UsersQueryResult
  alias RemotexWeb.Controllers.RandomUsers

  describe "get/2" do
    test "It should returns 200 with valid response body when calling / endpoint" do
      with_mock Remotex.Core.Engine,
        query_users: fn -> {:ok, %UsersQueryResult{users: [], queried_at: nil}} end do
        conn = conn(:get, "/", %{})
        response = RandomUsers.get(conn, %{})

        assert response.status == 200
        assert response.resp_body == "{\"timestamp\":null,\"users\":[]}"
      end
    end

    test "It should returns 500 with valid reason when calling / endpoint" do
      fun = fn ->
        with_mock Remotex.Core.Engine, query_users: fn -> {:error, :a_very_specific_reason} end do
          conn = conn(:get, "/", %{})
          response = RandomUsers.get(conn, %{})

          assert response.status == 500
          assert response.resp_body == "{\"error\":\"a_very_specific_reason\"}"
        end
      end

      assert capture_log(fun) =~ "Get random users failed due to: :a_very_specific_reason"
    end
  end
end
