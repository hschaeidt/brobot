defmodule GGWP.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    [bot_config] = Application.fetch_env!(:ggwp, :bots)

    children = [
      # Start the Ecto repository
      GGWP.Repo,
      # Start the Telemetry supervisor
      GGWPWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GGWP.PubSub},
      # Start the Endpoint (http/https)
      GGWPWeb.Endpoint,
      # Start a worker by calling: GGWP.Worker.start_link(arg)
      # {GGWP.Worker, arg}
      {TMI.Supervisor, bot_config},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GGWP.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GGWPWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
