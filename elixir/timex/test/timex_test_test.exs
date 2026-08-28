defmodule TimexTestTest do
  use ExUnit.Case
  doctest TimexTest

  test "greets the world" do
    assert TimexTest.hello() == :world
  end
end
