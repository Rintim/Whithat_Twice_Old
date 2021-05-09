defmodule Whithat.ConfigTest do
  use ExUnit.Case
  doctest Whithat.Config

  test "greets the world" do
    assert Whithat.Config.hello() == :world
  end
end
