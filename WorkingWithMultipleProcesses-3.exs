defmodule WorkingWithMultipleProcess3 do
  import :timer, only: [ sleep: 1 ]


  def run do
    Process.flag(:trap_exit, true)
    _res = spawn_link(__MODULE__,:parent, [self()])
    :timer.sleep(500)
    receive_msg()
  end

  def parent(sender_pid) do
    send(sender_pid, "Boom")
    exit(:boom)
  end

  def receive_msg do
    receive do
      msg ->
        IO.puts "#{inspect msg}"
        receive_msg()
      after 500 ->
        IO.puts "timeout"
    end
  end
  
end
WorkingWithMultipleProcess3.run