defmodule Remotex.Core.Schemas.User do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts type: :utc_datetime_usec
  @required_fields [:points]

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

  defp all_fields do
    __MODULE__.__schema__(:fields)
  end

  def create_changeset(params) do
    %__MODULE__{}
    |> cast(params, all_fields())
    |> validate_required(@required_fields)
    |> validate_points_range()
  end

  def validate_points_range(changeset) do
    name = get_field(changeset, :points)

    if name <= 100 && name >= 0 do
      changeset
    else
      add_error(changeset, :points, "is not in 0-100 range")
    end
  end
end
