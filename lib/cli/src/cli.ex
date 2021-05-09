# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
# This File if From Theopse (Self@theopse.org)
# Licensed under BSD-2-Caluse
# File:	cli.ex (Whithat/lib/cli/src/cli.ex)
# Content:	Whithat Application CLI Enterance
# Copyright (c) 2020 Theopse Organization All rights reserved
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

defmodule Whithat.CLI do

  # Import Standard Library
  import Standard

  begin "Module Info" do
    @moduledoc """
    Documentation for `Cli`.
    """
  end

  begin "Function Defination" do
    begin :M do
      begin {:main, 1} do
        @spec main([binary]) :: no_return
        def main(_args \\ []), do: nyi({:main})
      end
    end
  end

end
