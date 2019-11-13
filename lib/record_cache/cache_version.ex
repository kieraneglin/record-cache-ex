defmodule RecordCache.CacheVersion do
  @moduledoc ~S"""
  Provides one method, `call`, that transforms a struct (presumably from Ecto)
  into a cache version in the same fashion that ActiveRecord would.
  """

  @doc ~S"""
  Transforms a struct into a cache version similar to ActiveRecord.
  Currently only works on single records.

  Supports utc_datetime and naive_datetime (with or without usec)
  """
  def call(record) do
  end
end
