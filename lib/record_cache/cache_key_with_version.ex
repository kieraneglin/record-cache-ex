defmodule RecordCache.CacheKeyWithVersion do
  @moduledoc ~S"""
  Provides one method, `call`, that transforms a struct (presumably from Ecto)
  into a cache key with record version
  """

  alias RecordCache.{
    CacheKey,
    CacheVersion
  }

  @doc ~S"""
  Transforms a struct into a cache key with version similar to ActiveRecord.
  Currently only works on single records.
  """
  def call(%{__meta__: %{state: :built}} = record) do
    CacheKey.call(record)
  end

  def call(record) do
    "#{CacheKey.call(record)}-#{CacheVersion.call(record)}"
  end
end
