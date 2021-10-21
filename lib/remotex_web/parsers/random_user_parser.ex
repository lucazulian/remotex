defmodule RemotexWeb.Values.RandomUserParser do
  @moduledoc false

  alias Remotex.Core.Schemas.User
  alias RemotexWeb.Values.RandomUser

  @spec parse(result :: User.t()) :: RandomUser.t()
  def parse(%User{} = result) do
    %RandomUser{
      id: result.id,
      points: result.points
    }
  end
end
