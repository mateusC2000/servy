defmodule Refuge.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RefugeWeb.Telemetry,
      Refuge.Repo,
      {DNSCluster, query: Application.get_env(:refuge, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Refuge.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Refuge.Finch},
      # Start a worker by calling: Refuge.Worker.start_link(arg)
      # {Refuge.Worker, arg},
      # Start to serve requests, typically the last entry
      RefugeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Refuge.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RefugeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
