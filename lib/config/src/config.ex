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

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__.Server, state, name: __MODULE__.Server)
  end

  def fetch(index) do
    GenServer.call(__MODULE__.Server, {:get, index})
    |> case do
      [] -> nil
      [result] -> {:ok, result}
    end
  end

  def add(index, value) do
    GenServer.cast(__MODULE__.Server, {:insert, index, value})
    :ok
  end

  def add_new(index, value), do: GenServer.call(__MODULE__.Server, {:insert, index, value})
end
