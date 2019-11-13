defmodule RecordCacheTest.CacheKeyTest do
  use ExUnit.Case
  alias RecordCache.CacheKey

  defmodule User do
    defstruct [:id, :updated_at, :__meta__]
  end

  describe "call/1" do
    test "Model names are inferred by ecto table name" do
      record =
        %User{
          __meta__: %{
            state: :built,
            source: "admin_users"
          }
        }

      cache_key = CacheKey.call(record)

      assert String.starts_with?(cache_key, "admin_users/")
    end

    test "Non-persisted records are appended with /new" do
      new_record =
        %User{
          __meta__: %{
            state: :built,
            source: "users"
          }
        }

      cache_key = CacheKey.call(new_record)

      assert cache_key == "users/new"
    end

    test "Persisted records are appended with their ID" do
      persisted_record =
        %User{
          id: 1,
          __meta__: %{
            state: :loaded,
            source: "users"
          }
        }

      cache_key = CacheKey.call(persisted_record)

      assert cache_key == "users/1"
    end
  end
end
