defmodule Koala.EntriesTest do
  use Koala.DataCase

  alias Koala.Entries
  alias Koala.Entries.Entry
  alias Koala.TestSupport.Factories.EntryFactory

  @valid_attrs %{customers_number: 42, price: 120.5}
  @update_attrs %{customers_number: 43, price: 456.7}
  @invalid_attrs %{customers_number: nil, price: nil}

  describe "entries" do
    test "list_entries/0 returns all entries" do
      entry = EntryFactory.create()
      assert entry in Entries.list_entries()
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = EntryFactory.create()
      assert Entries.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      assert {:ok, %Entry{} = entry} = Entries.create_entry(@valid_attrs)
      assert entry.customers_number == 42
      assert entry.price == 120.5
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entries.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = EntryFactory.create()
      assert {:ok, entry} = Entries.update_entry(entry, @update_attrs)
      assert %Entry{} = entry
      assert entry.customers_number == 43
      assert entry.price == 456.7
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = EntryFactory.create()
      assert {:error, %Ecto.Changeset{}} = Entries.update_entry(entry, @invalid_attrs)
      assert entry == Entries.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = EntryFactory.create()
      assert {:ok, %Entry{}} = Entries.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Entries.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = EntryFactory.create()
      assert %Ecto.Changeset{} = Entries.change_entry(entry)
    end
  end
end
