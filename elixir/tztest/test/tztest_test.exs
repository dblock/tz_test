defmodule TztestTest do
  use ExUnit.Case
  doctest Tztest

  test "greets the world" do
    assert Tztest.hello() == :world
  end
end
