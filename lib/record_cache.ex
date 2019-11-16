defmodule RecordCache do
  alias RecordCache.{
    CacheKey,
    CacheVersion,
    CacheKeyWithVersion
  }

  def cache_key(record) do
    CacheKey.call(record)
  end

  def cache_version(record) do
    CacheVersion.call(record)
  end

  def cache_key_with_version(record) do
    CacheKeyWithVersion.call(record)
  end
end
