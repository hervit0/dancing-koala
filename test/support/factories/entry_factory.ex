defmodule Koala.TestSupport.Factories.EntryFactory do
  import Ecto

  alias Koala.Entries
  alias Koala.Entries.Entry
  alias Koala.Repo
  alias Koala.TestSupport.Factories.EventFactory

  @create_attrs %{customers_number: 42, price: 120.5}

  def create(attrs \\ @create_attrs) do
    {:ok, entry} = Entries.create_entry(attrs)
    entry
  end

  def create_with_event(attrs \\ @create_attrs) do
    event = EventFactory.create()

    changeset =
      event
      |> build_assoc(:entries)
      |> Entry.changeset(attrs)

    {:ok, entry} = Repo.insert(changeset)
    {entry, event}
  end
end
