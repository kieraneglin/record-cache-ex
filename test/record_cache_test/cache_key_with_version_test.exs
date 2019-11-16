defmodule RecordCacheTest.CacheKeyWithVersionTest do
  use ExUnit.Case
  alias RecordCache.CacheKeyWithVersion

  defmodule User do
    defstruct [:id, :__meta__, :updated_at]
  end

  describe "call/1" do
    test "Returns a cache key with version for persisted records" do
      record = %User{
        id: 1,
        updated_at: ~U[2001-02-03 12:34:56Z],
        __meta__: %{
          state: :loaded,
          source: "users"
        }
      }

      result = CacheKeyWithVersion.call(record)

      assert result == "users/1-20010203123456000000"
    end

    test "Doesn't return ID or version for non-persisted records" do
      new_record = %User{
        id: 1,
        updated_at: ~U[2001-02-03 12:34:56Z],
        __meta__: %{
          state: :built,
          source: "users"
        }
      }

      result = CacheKeyWithVersion.call(new_record)

      assert result == "users/new"
    end
  end
end
