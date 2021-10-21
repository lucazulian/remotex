defmodule Remotex.Core.Schemas.UserTest do
  use Remotex.DataCase

  alias Remotex.Core.Schemas.User

  @expected_fields_with_types [
    {:id, :id},
    {:points, :integer},
    {:inserted_at, :utc_datetime_usec},
    {:updated_at, :utc_datetime_usec}
  ]

  describe "fields and types" do
    @tag :schema_definition
    test "It should return the correct fields and types" do
      actual_fields_with_types =
        for field <- User.__schema__(:fields) do
          type = User.__schema__(:type, field)
          {field, type}
        end

      assert Enum.sort(actual_fields_with_types) ==
               Enum.sort(@expected_fields_with_types)
    end
  end
end
