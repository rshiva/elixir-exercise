defmodule ProcessChallenge do

  def controller(counter_pid \\ nil) do
    receive do
     :pid? ->
      IO.inspect(counter_pid)
      controller(counter_pid)
      :start ->
        counter_pid = spawn(&counter/0)
        send counter_pid, 1
        controller(counter_pid)
      :stop ->
        Process.exit(counter_pid, :kill)
        controller(counter_pid)
      _ ->
        controller(counter_pid)
    end
    
  end

  def counter() do
   receive do
      value ->
      IO.puts "value -> #{value}"
       Process.sleep(2500)
      send(self(), value * 2)
   end
   counter()
  end
  
end