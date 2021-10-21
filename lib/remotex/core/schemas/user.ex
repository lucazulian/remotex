defmodule Remotex.Core.Schemas.User do
  @moduledoc false

  use Ecto.Schema

  @timestamps_opts type: :utc_datetime_usec

  @type t :: %__MODULE__{
          id: integer(),
          points: integer(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  schema "users" do
    field :points, :integer, default: 0
    timestamps()
  end
end
