defmodule RecordCache.CacheKey do
  @moduledoc ~S"""
  Provides one method, `call`, that transforms a struct (presumably from Ecto)
  into a cache key in the same fashion that ActiveRecord would.
  """

  @doc ~S"""
  Transforms a struct into a cache key similar to ActiveRecord.
  Currently only works on single records.

  If a record is new, it returns `<model>/new`
  If a record is persisted, it returns <model>/<id>

  Unlike ActiveRecord, this method will never include a cache version.
  For that, use RecordCache.cache_key_with_version/1
  """
  def call(%{__meta__: %{source: source, state: :built}}) do
    "#{source}/new"
  end

  def call(%{id: id, __meta__: %{source: source, state: :loaded}}) do
    "#{source}/#{id}"
  end
end
