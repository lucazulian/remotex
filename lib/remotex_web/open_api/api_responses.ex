defmodule RemotexWeb.OpenApi.ApiResponses do
  @moduledoc false

  require OpenApiSpex

  alias OpenApiSpex.Schema

  defmodule RandomUsersErrorResponse do
    @moduledoc """
    OpenApi schema for json error response.
    """

    OpenApiSpex.schema(%{
      type: :object,
      properties: %{
        error: %Schema{type: :string, example: "something_very_wrong"}
      },
      required: [:error]
    })
  end

  defmodule RandomUser do
    @moduledoc """
    OpenApi schema of RandomUser object.
    """

    OpenApiSpex.schema(%{
      type: :object,
      properties: %{
        id: %Schema{type: :integer, format: :int32, example: 300},
        points: %Schema{type: :integer, format: :int32, example: 98}
      }
    })
  end

  defmodule RandomUsersResponse do
    @moduledoc """
    OpenApi schemas of RandomUsersResponse controller success response.
    """

    OpenApiSpex.schema(%{
      type: :object,
      properties: %{
        users: %Schema{type: :array, items: RandomUser},
        timestamp: %Schema{
          type: :string,
          description: "Last query timestamp",
          format: :"date-time"
        }
      }
    })
  end
end
