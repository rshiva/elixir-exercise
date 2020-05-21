defmodule  StackSupervisor.Stash do
  use GenServer

  @me __MODULE__
  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: @me)
  end


  def init(state) do
    {:ok, state}
  end

  def  get() do
    GenServer.call(@me, { :get })
  end

  def update(value) do
    GenServer.cast(@me, { :update, value })
  end

  def handle_call({ :get }, _from, state ) do
    { :reply, state, state }
  end

  def handle_cast({ :update, value }, state) do
    state = [ value | state]
    { :noreply,  state }
  end

end
