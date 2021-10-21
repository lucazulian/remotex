defmodule Remotex.Core.Behaviours.UsersQueryBulkTest do
  use Remotex.DataCase

  alias Remotex.Core.Behaviours.UsersQueryBulk
  alias Remotex.Core.Schemas.User
  alias Remotex.Core.Values.EngineState
  alias Remotex.Core.Values.UsersQueryResult
  alias Remotex.Repo

  describe "update/0" do
    test "success: it updates all users with random points" do
      [%User{points: -1}, %User{points: -2}] |> Enum.map(&Repo.insert/1)

      assert :ok = UsersQueryBulk.update()

      users_from_db = Repo.all(User)

      for %User{points: points} <- users_from_db do
        assert points >= 0 && points <= 100,
               "Points #{points} did not match 0-100 range expectation"
      end
    end
  end

  describe "fetch/1" do
    test "success: it fetches to users with points greater or equal than specified" do
      queried_at = ~U[2021-10-21 10:47:08.067366Z]
      max_number = 10

      [
        %User{points: 10},
        %User{points: 20},
        %User{points: 30},
        %User{points: 1},
        %User{points: 2},
        %User{points: 3}
      ]
      |> Enum.map(&Repo.insert/1)

      assert {:ok, %UsersQueryResult{users: users, queried_at: engine_queried_at}} =
               UsersQueryBulk.fetch(%EngineState{
                 max_number: max_number,
                 queried_at: queried_at
               })

      assert engine_queried_at == queried_at
      assert Enum.count(users) == 2

      for %User{points: points} <- users do
        assert points >= 10,
               "Points #{points} did not match max_number #{max_number} expected"
      end
    end
  end
end
