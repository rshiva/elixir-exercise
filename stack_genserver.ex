defmodule StackGenServer do
  use GenServer

  @server __MODULE__

  def start_link(state \\ []) do
    GenServer.start_link(@server, state, name:  @server)
  end

  def init(state) do
    {:ok, state}
  end

  def pop do
    GenServer.call(@server, :pop)
  end

  def push(value) do
    GenServer.cast(@server, {:push, value})
  end

  def handle_cast({:push, value}, state ) do
    state = [value | state]
    {:noreply, state}
  end

  def handle_call(:pop, _from , state) do
    cond do
      state === [] ->
        {:reply, [], state}
      state ->
        [ head | tail ] = state
        {:reply, head, tail}
    end
  end

end

"""
c "stack_genserver.ex"

StackGenServer.start_link()

StackGenServer.push(5)
StackGenServer.push("cat")
StackGenServer.push(9)

StackGenServer.pop()

"""
