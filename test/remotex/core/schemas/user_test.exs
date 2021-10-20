defmodule Remotex.Core.Schemas.UserTest do
  use Remotex.DataCase

  alias Ecto.Changeset
  alias Remotex.Core.Schemas.User

  @expected_fields_with_types [
    {:id, :id},
    {:points, :integer},
    {:inserted_at, :utc_datetime_usec},
    {:updated_at, :utc_datetime_usec}
  ]
  @mutable_fields [:points]

  describe "fields and types" do
    @tag :schema_definition
    test "it has the correct fields and types" do
      actual_fields_with_types =
        for field <- User.__schema__(:fields) do
          type = User.__schema__(:type, field)
          {field, type}
        end

      assert Enum.sort(actual_fields_with_types) ==
               Enum.sort(@expected_fields_with_types)
    end
  end

  describe "create_changeset/1" do
    test "success: returns a valid changeset when given valid arguments" do
      valid_params = %{points: 10}

      changeset = User.create_changeset(valid_params)
      assert %Changeset{valid?: true, changes: changes} = changeset

      for {field, _} <- @expected_fields_with_types,
          field not in @mutable_fields do
        assert Map.get(changes, field) == valid_params[Atom.to_string(field)]
      end

      assert changes.points == valid_params.points
    end

    test "error: returns an error changeset when given un-castable values" do
      invalid_params = %{points: []}

      assert %Changeset{valid?: false, errors: errors} = User.create_changeset(invalid_params)

      for field <- @mutable_fields do
        {_, meta} = errors[field]

        assert meta[:validation] == :cast,
               "The validation type, #{meta[:validation]}, is incorrect."
      end
    end

    test "error: returns an error changeset when given non-valid values" do
      invalid_params = %{points: 101}

      assert %Changeset{valid?: false, errors: errors} = User.create_changeset(invalid_params)

      for field <- @mutable_fields do
        {message, meta} = errors[field]

        assert meta[:validation] == :invalid,
               "The validation filed, #{meta[:validation]}, is incorrect."

        assert message == "is not in 0-100 range",
               "The validation message, #{message}, is incorrect."
      end
    end
  end
end
