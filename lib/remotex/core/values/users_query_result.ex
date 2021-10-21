defmodule Remotex.Core.Values.UsersQueryResult do
  @moduledoc false

  alias Remotex.Core.Schemas.User

  @type t :: %__MODULE__{
          users: list(User.t()),
          queried_at: DateTime.t() | nil
        }

  @derive Jason.Encoder
  defstruct [:users, :queried_at]
end
