#! /usr/bin/env elixir
# encoding: utf-8
# -*- coding: utf-8 -*-
# vim:set fileencoding=utf-8:

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
# This File if From Theopse (Self@theopse.org)
# Licensed under BSD-2-Caluse
# File:	bilibili.ex (Whithat/lib/bilibili/src/bilibili.ex)
# Content:	Whithat Application CLI Enterance
# Copyright (c) 2020 Theopse Organization All rights reserved
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

defmodule Whithat.Bilibili do
  # Import Standard Library
  import Standard

  begin "Module Info" do
    @moduledoc """
    Documentation for `Bilibili`.
    """
  end

  begin "Aliases" do
    alias Bradot.{Bvid, Video}
  end

  begin "Function Defination" do
    begin E do
      begin {:enterance, 2} do
        def enterance(env, ["bangumi" | args]), do: enterance(env, ["--bangumi" | args])

        def enterance(env, args) do
          options = [
            strict: [
              bangumi: :boolean,
              # Bangumi interrelated
              # 番劇相關參數
              ep: :string,
              ss: :string,
              # Video interrelated
              # 視頻相關參數
              avid: :string,
              aid: :string,
              bvid: :string,
              # General interrelated
              # 通用參數
              pages: :string,
              quality: :string
            ],
            aliases: [
              b: :bangumi,
              s: :ss
            ]
          ]

          {:ok, count} = Agent.start(fn -> 0 end)

          # :ets.insert_new(env, {:count, count})

          {command, arguments, _} = OptionParser.parse(args, options)

          bangumi? = Access.get(command, :bangumi)

          check(
            bangumi?,
            do_bangumi(env, command, arguments, count),
            do_video(env, command, arguments, count)
          )
        end
      end
    end
  end

  begin "Private Function" do
    begin :C do
      begin {:check_vid, 2} do
        defp check_vid(nil, nil, list, count) do
          vid = count_get!(list, count)

          check(
            Regex.match?(~r/^BV/, vid),
            check_vid(nil, vid, list, count),
            check_vid(vid, nil, list, count)
          )
        end

        defp check_vid(aid, nil, _, _), do: {aid, Bvid.encode(aid)}
        defp check_vid(nil, bvid, _, _), do: {Bvid.decode(bvid), bvid}
        defp check_vid(aid, bvid, _, _), do: {aid, bvid}
      end

      begin {:count_get, 1} do
        defp count_get(count) do
          Agent.get(count, fn item -> item end)
        end
      end

      begin {:count_get, 2} do
        defp count_get(list, count) do
          result = Enum.fetch(list, Agent.get(count, fn item -> item end))
          :ok = Agent.update(count, &Kernel.+(&1, 1))
          result
        end
      end

      begin {:count_get!, 2} do
        defp count_get!(list, count) do
          {:ok, result} = count_get(list, count)
          result
        end
      end
    end

    begin :D do
      begin {:do_bangumi, 3} do
        def do_bangumi(_env, command, arguments, count) do
          ss = Access.get(command, :ss)

          ep =
            !ss &&
              (Access.get(command, :ep) || count_get!(arguments, count))

          nyi({:bangumi, "Not Done", ss, ep, {count_get(count), arguments}})
        end
      end

      begin {:do_video, 3} do
        def do_video(_env, command, arguments, count) do
          aid = Access.get(command, :aid) || Access.get(command, :avid)
          bvid = Access.get(command, :bvid)

          {aid, bvid} = check_vid(aid, bvid, arguments, count)

          nyi({:bilivideo, "Config not done", aid, bvid, {count_get(count), arguments}})
        end
      end
    end
  end
end
