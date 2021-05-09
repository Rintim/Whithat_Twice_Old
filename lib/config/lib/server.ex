#! /usr/bin/env elixir
# encoding: utf-8
# -*- coding: utf-8 -*-
# vim:set fileencoding=utf-8:

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
# This File if From Theopse (Self@theopse.org)
# Licensed under BSD-2-Caluse
# File:	config.ex (Whithat/lib/config/src/config.ex)
# Content:	Whithat Application CLI Enterance
# Copyright (c) 2021 Theopse Organization All rights reserved
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

defmodule Whithat.Config.Server do

  import Standard

  # behaviour GenServer
  use GenServer

  begin "Function Defination" do
    begin :H do
      begin {:handle_call, 3} do
        def handle_call(:alive, _from, state), do: {:reply, true, state}
        def handle_call({:get, index}, _from, state) do
          result = pipe([
            [{{index, :"$1"}, [], [:"$1"]}],
            # [{{:"$1", :"$2"}, [{:"=:=", index, :"$1"}], [:"$2"]}],
            # :ets.fun2ms(fn {^index, item} -> item end),
            # {:ets, :fun2ms, [:function, :called, :with, :real, :fun, :should, :be, :transformed, :with, :parse_transform, :or, :called, :with, :a, :fun, :generated, :in, :the, :shell]}
            {2, :ets.select(state)}
          ])
          {:reply, result, state}
        end
        def handle_call({:insert, index, value}, _from, state) do
          result = :ets.insert_new(state, {index, value})
          {:reply, result, state}
        end
      end

      begin {:handle_cast, 2} do
        def handle_cast({:insert, index, value}, state) do
          :ets.insert(state, {index, value})
          {:noreply, state}
        end
      end
    end
    begin :I do
      begin {:init, 1} do
        def init(map) when is_map(map) do
          Map.to_list(map)
          |> init
        end

        def init([]), do: {:ok, :ets.new(:config, [:set, :protected])}

        def init(state) do
          ets = :ets.new(:config, [:set, :protected])
          state
          |> Enum.each(&:ets.insert_new(ets, &1))
          {:ok, ets}
        end
      end
    end


  end

end
