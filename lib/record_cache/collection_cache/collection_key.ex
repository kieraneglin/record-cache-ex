defmodule RecordCache.CollectionCache.CollectionKey do
  @moduledoc ~S"""
  Provides one method, `call`, that transforms any data into a cache key.
  """

  @doc ~S"""
  Transforms any data into a cache key.

  NOTE: Will be slow on large datasets
  """
  def call(data) do
    serialized_data = :erlang.term_to_binary(data)
    hash = :crypto.hash(:sha, serialized_data) |> Base.encode16(case: :lower)

    "collection/#{hash}"
  end
end
