defmodule FlameTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: FlameTest.Worker.start_link(arg)
      {FLAME.Pool,
       [
         name: FlameTest.Pool,
         backend: FlameTest.Backend,
         min: 0,
         max: 1,
         max_concurrency: 1,
         log: :debug
       ]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FlameTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def call, do: FLAME.cast(FlameTest.Pool, fn -> Process.sleep(:infinity) end)

  def sup_tree, do: Process.whereis(FlameTest.Pool.PoolSup) |> Supervisor.which_children()
end
