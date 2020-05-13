defmodule GreetProcess do

  def greet do
    receive do
      {caller_id, :hello, name} ->
        IO.puts("Welcome to the process #{name}")
        {:ok, name}
      {caller_id, :kitchen, name} -> 
        IO.puts("Singing in the Kitchen #{name}")
       send caller_id, {:response, name}
    end
    greet()
  end

  def counter do
    receive do
      value ->
        IO.puts(value)
        Process.sleep(500)
        send(self(), value + 1 )
    end
    counter()
  
  end
end


#   def country do
#     receive do
#      {:french, name} ->
#         gid = spawn(GreetProcess, :greet, [])
#         # {:response, greeter_name} = send gid, {self(), :kitchen, name}
#         IO.puts( send gid, {self(), :kitchen, name})
#         # IO.puts("Bonjour, #{greeter_name}")
#     end
#   end
# end


# gid = spawn(GreetProcess, :country, [])
# send gid, {:french, "Bhamila"}