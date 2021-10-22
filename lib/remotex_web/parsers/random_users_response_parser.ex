defmodule RemotexWeb.Values.RandomUsersResponseParser do
  @moduledoc false

  alias Remotex.Values.UsersQueryResult
  alias RemotexWeb.Values.RandomUserParser
  alias RemotexWeb.Values.RandomUsersResponse

  @spec parse(result :: UsersQueryResult.t()) :: RandomUsersResponse.t()
  def parse(%UsersQueryResult{} = result) do
    %RandomUsersResponse{
      users: Enum.map(result.users, &RandomUserParser.parse/1),
      timestamp: result.queried_at
    }
  end

  def parse(_), do: {:error, :invalid_users_query_result}
end
