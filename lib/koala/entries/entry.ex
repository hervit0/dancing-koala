defmodule Koala.Entries.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  alias Koala.Events.Event

  @timestamps_opts type: :utc_datetime
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "entries" do
    field(:customers_number, :integer)
    field(:price, :float)

    belongs_to(:event, Event, type: :binary_id)

    timestamps()
  end

  @doc false
  def changeset(entry, attrs \\ %{}) do
    entry
    |> cast(attrs, [:customers_number, :price])
    |> validate_required([:customers_number, :price])
  end
end
