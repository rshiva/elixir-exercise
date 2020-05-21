defmodule StackSupervisor do
  use GenServer

  @server __MODULE__

  def start_link(state \\ []) do
    GenServer.start_link(@server, state, name:  @server)
  end

  def init(_) do
    # {:ok, state}
    { :ok, StackSupervisor.Stash.get() }
  end

  def pop do
    GenServer.call(@server, :pop)
  end

  def push(value) do
    GenServer.cast(@server, {:push, value})
  end

  def handle_cast({:push, value}, state ) do
    cond do
      is_integer(value) ->
        state = [value | state]
      {:noreply, state}
    end
    #making it crash to check the state
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

  def terminate(_reason, state) do
    StackSupervisor.Stash.update(state)
  end

end

  """
  c "stack_genserver.ex"

  StackSupervisor.start_link()

  StackSupervisor.push(5)
  StackSupervisor.push("cat")
  StackSupervisor.push(9)

  StackSupervisor.pop()

  """

