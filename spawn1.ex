defmodule Spawn1 do

  def greet do
    receive do
      {sender, value} ->
        # IO.puts "Hello #{value}"
        send(sender, {:ok, "Hello #{value}"})
        greet()
    end
  end
end


spid =  spawn(Spawn1, :greet, [])
send(spid,{self(), "Shiva" })

receive do
  {:ok, message} ->
    IO.puts message
end


send(spid, {self(), "Kermit!"} )
receive do
  {:ok, message} -> 
    IO.puts message
  after 500 ->
    IO.puts "The greeter has gone away"
end
