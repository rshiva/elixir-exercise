defmodule GuessNumberGenserver do
  use GenServer

  #generate number
  #guess the number
  #number matched you won
  #If the user won .. process restart with new game

  def start_link(state \\ %{}) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
    start_game()
  end

  def init(state) do
    {:ok, state}
  end

  def start_game() do
    rand = Enum.random(1..25)
    IO.puts("Secret number generated. Now guess it!! \n Number is between 1 to 25")
    GenServer.cast(__MODULE__, {:add, %{secret: rand}})
  end

  def guess(value) do
    GenServer.call(__MODULE__, {:guess, value})
  end

  def handle_cast({:add, %{secret: value}}, state) do
    {:noreply, Map.put(state ,:secret, value)}
  end

  def handle_call({:guess,value}, _from, state) do
    secret_number =  Map.get(state, :secret)
    # IO.puts("value -> #{value} -- secret_number -> #{secret_number}")
     cond do
        value == secret_number ->
          IO.puts("You won!!")
        value >= secret_number ->
          IO.puts("Enter number greater than lucky number")
        value <= secret_number ->
            IO.puts("Enter number less than lucky number")
     end
    {:reply, value, state}
  end

end
