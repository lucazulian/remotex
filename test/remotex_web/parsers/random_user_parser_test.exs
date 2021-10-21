defmodule RemotexWeb.Parsers.RandomUserParserTest do
  use ExUnit.Case, async: true

  alias Remotex.Core.Schemas.User
  alias RemotexWeb.Values.RandomUser
  alias RemotexWeb.Values.RandomUserParser

  test "parse/1" do
    user = %User{id: 1, points: 99}

    assert RandomUserParser.parse(user) == %RandomUser{id: 1, points: 99}
  end
end
