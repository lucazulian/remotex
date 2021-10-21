defmodule RemotexWeb.OpenApi.ApiSpec do
  @moduledoc false

  @behaviour OpenApiSpex.OpenApi

  alias OpenApiSpex.Info
  alias OpenApiSpex.OpenApi
  alias OpenApiSpex.Paths
  alias OpenApiSpex.Server
  alias RemotexWeb.Endpoint
  alias RemotexWeb.Router

  @impl OpenApi
  def spec do
    %OpenApi{
      servers: [
        %{Server.from_endpoint(Endpoint) | description: "Public endpoint"}
      ],
      info: %Info{
        title: to_string(Application.spec(:remotex, :description)),
        version: to_string(Application.spec(:remotex, :vsn))
      },
      paths: Paths.from_router(Router)
    }
    |> OpenApiSpex.resolve_schema_modules()
  end
end
