defmodule InfoSys.Counter do
  use GenServer

  def inc(pid), do: GenServer.cast(pid, :inc) #cast is used for async messages

  def dec(pid), do: GenServer.cast(pid, :dec)

  def val(pid) do
    GenServer.call(pid, :val) #call is used for sync messages
  end

  def start_link(initial_val) do
    GenServer.start_link(__MODULE__, initial_val)
  end

  def init(initial_val) do
    Process.send_after(self(), :tick, 1000)
    {:ok, initial_val}
  end

  def handle_info(:tick, val) when val < 0, do: raise "boom"

  def handle_info(:tick, val) do
    IO.puts("tick #{val}")
    Process.send_after(self(), :tick, 1000)
    {:noreply, val - 1}
  end

  def handle_cast(:inc, val) do
    {:noreply, val + 1}
  end

  def handle_cast(:dec, val) do
    {:noreply, val - 1}
  end

  def handle_call(:val, _from, val) do
    {:reply, val, val}
  end
end

# Agent implementation

import Agent

{:ok, agent} = start_link(fn -> 5 end, name: MyAgent)
update(agent, &(&1 + 1))
get(agent, &(&1))
stop(agent)
