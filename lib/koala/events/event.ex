defmodule Koala.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  alias Koala.Entries.Entry

  @timestamps_opts type: :utc_datetime
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "events" do
    field :date, :utc_datetime
    field :expenses, :float
    field :location, :string

    has_many :entries, Entry

    timestamps()
  end

  @doc false
  def changeset(event, attrs \\ %{}) do
    event
    |> cast(attrs, [:location, :expenses, :date])
    |> validate_required([:location, :expenses, :date])
  end
end
