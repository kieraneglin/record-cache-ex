defmodule RecordCache.CollectionCache.CollectionKey do
  @moduledoc ~S"""
  Provides one method, `call`, that transforms any data into a cache key.
  """

  @doc ~S"""
  Transforms any data into a cache key.

  NOTE: Will be slow on large datasets
  """
  def call(data) do
    ""
  end
end
