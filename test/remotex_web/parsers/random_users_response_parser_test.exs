defmodule RemotexWeb.Parsers.RandomUsersResponseParserTest do
  use ExUnit.Case, async: true

  alias Remotex.Core.Schemas.User
  alias Remotex.Core.Values.UsersQueryResult
  alias RemotexWeb.Values.RandomUser
  alias RemotexWeb.Values.RandomUsersResponse
  alias RemotexWeb.Values.RandomUsersResponseParser

  test "parse/1" do
    queried_at = ~U[2021-10-21 10:47:08.067366Z]

    users_query_result = %UsersQueryResult{
      users: [
        %User{id: 1, points: 99},
        %User{id: 12, points: 56}
      ],
      queried_at: queried_at
    }

    assert RandomUsersResponseParser.parse(users_query_result) ==
             %RandomUsersResponse{
               timestamp: ~U[2021-10-21 10:47:08.067366Z],
               users: [
                 %RandomUser{id: 1, points: 99},
                 %RandomUser{id: 12, points: 56}
               ]
             }
  end
end
