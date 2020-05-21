defmodule StackSupervisorTest do
  use ExUnit.Case
  doctest StackSupervisor

  test "greets the world" do
    assert StackSupervisor.hello() == :world
  end
end
