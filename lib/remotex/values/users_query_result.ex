defmodule Remotex.Values.UsersQueryResult do
  @moduledoc false

  alias Remotex.Schemas.User

  @type t :: %__MODULE__{
          users: list(User.t()),
          queried_at: DateTime.t() | nil
        }

  @derive Jason.Encoder
  defstruct [:users, :queried_at]
end
