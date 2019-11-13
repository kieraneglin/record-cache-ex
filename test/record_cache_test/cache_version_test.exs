defmodule RecordCacheTest.CacheVersionTest do
  use ExUnit.Case
  alias RecordCache.CacheVersion

  defmodule User do
    defstruct [:updated_at]
  end

  describe "call/1" do
    test "Returns nil if there is no updated_at" do
      record = %User{
        updated_at: nil
      }

      version = CacheVersion.call(record)

      assert version == nil
    end

    test "Returns expected format for DateTime" do
      record = %User{
        updated_at: ~U[2001-02-03 12:34:56Z]
      }

      version = CacheVersion.call(record)

      assert version == "20010203123456000000"
    end

    test "Returns expected format for DateTime with usec" do
      record = %User{
        updated_at: ~U[2001-02-03 12:34:56.123456Z]
      }

      version = CacheVersion.call(record)

      assert version == "20010203123456123456"
    end

    test "Returns expected format for NaiveDateTime" do
      record = %User{
        updated_at: ~N[2001-02-03 12:34:56]
      }

      version = CacheVersion.call(record)

      assert version == "20010203123456000000"
    end

    test "Returns expected format for NaiveDateTime with usec" do
      record = %User{
        updated_at: ~N[2001-02-03 12:34:56.123456]
      }

      version = CacheVersion.call(record)

      assert version == "20010203123456123456"
    end
  end
end
