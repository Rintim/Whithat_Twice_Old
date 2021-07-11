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

defmodule Whithat.Config do
  import Standard

  begin "Function Defination" do
    begin :A do
      begin {:add, 2} do
        def add(index, value) do
          GenServer.cast(__MODULE__.Server, {:insert, index, value})
          :ok
        end
      end

      begin {:add_new, 2} do
        def add_new(index, value), do: GenServer.call(__MODULE__.Server, {:insert, index, value})
      end
    end

    begin :F do
      begin {:fetch, 1} do
        def fetch(index) do
          GenServer.call(__MODULE__.Server, {:get, index})
          |> case do
            [] -> nil
            [result] -> {:ok, result}
          end
        end
      end
    end

    begin :S do
      @spec start? :: boolean
      begin {:start?, 0} do
        def start? do
          try do
            GenServer.call(__MODULE__.Server, :alive)
          catch
            :exit, {:noproc, _} -> false
          end
        end
      end

      begin {:start_link, [0, 1]} do
        def start_link(state \\ []) do
          GenServer.start_link(__MODULE__.Server, state, name: __MODULE__.Server)
        end
      end
    end
  end


end
