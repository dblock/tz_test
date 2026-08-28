defmodule HumanizerTestTest do
  use ExUnit.Case
  doctest HumanizerTest

  test "greets the world" do
    assert HumanizerTest.hello() == :world
  end
end
