defmodule Koala.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:location, :string)
      add(:expenses, :float)
      add(:date, :utc_datetime)

      timestamps()
    end

    create table(:entries, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:customers_number, :integer)
      add(:price, :float)

      add(:event_id, references(:events, on_delete: :nothing, type: :binary_id))

      timestamps()
    end
  end
end
