defmodule RemotexWeb.Values.RandomUsersResponse do
  @moduledoc false

  alias RemotexWeb.Values.RandomUser

  @type t :: %__MODULE__{
          users: list(RandomUser.t()),
          timestamp: DateTime.t() | nil
        }

  @derive Jason.Encoder
  defstruct [:users, :timestamp]
end
