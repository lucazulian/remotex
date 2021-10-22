defmodule Remotex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, %{env: env}) do
    children =
      [
        # Start the Ecto repository
        Remotex.Repo,
        # Start the Telemetry supervisor
        RemotexWeb.Telemetry,
        # Start the PubSub system
        {Phoenix.PubSub, name: Remotex.PubSub},
        # Start the Endpoint (http/https)
        RemotexWeb.Endpoint
        # Start a worker by calling: Remotex.Worker.start_link(arg)
        # {Remotex.Worker, arg}
      ] ++ supervisors(env)

    opts = [strategy: :one_for_one, name: Remotex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RemotexWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp supervisors(:test), do: []
  defp supervisors(_), do: [Remotex.EngineSupervisor]
end
