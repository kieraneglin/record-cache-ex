defmodule RecordCacheTest.CollectionCache.CollectionKeyTest do
  use ExUnit.Case
  alias RecordCache.CollectionCache.CollectionKey

  describe "call/1" do
    test "Transforms any data into a cache key" do
      map_key = CollectionKey.call(%{test: true})
      int_key = CollectionKey.call(1)
      list_key = CollectionKey.call([1, 2, 3])
      bool_key = CollectionKey.call(true)

      keys = [map_key, int_key, list_key, bool_key]

      keys
      |> Enum.each(fn key ->
        assert String.starts_with?(key, "collection/")
        assert Enum.count(keys, &(&1 == key)) == 1
      end)
    end

    test "The same data generates the same cache key" do
      list_1 = [1, 2, %{test: true}]
      list_2 = [1, 2, %{test: true}]

      key_1 = CollectionKey.call(list_1)
      key_2 = CollectionKey.call(list_2)

      assert key_1 == key_2
    end
  end
end
