defmodule FlameTest.Backend do
  @moduledoc false

  @behaviour FLAME.Backend

  @impl true
  def init(_opts) do
    {:error, :just_fail}
    # {:ok, :fine}
  end

  @impl true
  def remote_boot(state) do
    # {:error, :just_fail}
    {:ok, spawn(fn -> IO.puts("Remote booting") && Process.sleep(:infinity) end), state}
  end
end
