defmodule RecordCache.CacheVersion do
  @moduledoc ~S"""
  Provides one method, `call`, that transforms a struct (presumably from Ecto)
  into a cache version in the same fashion that ActiveRecord would.
  """

  @usec_length 6

  @doc ~S"""
  Transforms a struct into a cache version similar to ActiveRecord.
  Currently only works on single records.

  Supports utc_datetime and naive_datetime (with or without usec)
  """
  def call(%{updated_at: nil}) do
    nil
  end

  def call(%{updated_at: updated_at}) do
    case formatted_time(updated_at) do
      [macro_time, micro_time] ->
        padded_micro_time = String.pad_trailing(micro_time, @usec_length, "0")
        "#{macro_time}#{padded_micro_time}"

      time_string ->
        padded_micro_time = String.duplicate("0", @usec_length)
        "#{time_string}#{padded_micro_time}"
    end
  end

  defp formatted_time(datetime_like) do
    datetime_like
    |> datetime_like.__struct__.to_iso8601(:basic)
    |> String.replace(~r/[A-Z]/, "")
    |> String.split(".")
  end
end
