defmodule KoalaWeb.EntryController do
  use KoalaWeb, :controller

  alias Koala.Entries
  alias Koala.Entries.Entry
  alias Koala.Events.Event
  alias Koala.Repo

  plug(:assign_event)

  defp assign_event(conn, _opts) do
    case conn.params do
      %{"event_id" => event_id} ->
        event = Repo.get(Event, event_id)
        assign(conn, :event, event)

      _ ->
        conn
    end
  end

  def index(conn, _params) do
    entries = Entries.list_entries()
    render(conn, "index.html", entries: entries)
  end

  def new(conn, _params) do
    changeset = Entries.change_entry(%Entry{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"entry" => entry_params}) do
    case Entries.create_entry(entry_params) do
      {:ok, _entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: event_entry_path(conn, :show, conn.assigns[:user]))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    entry = Entries.get_entry!(id)
    render(conn, "show.html", entry: entry)
  end

  def edit(conn, %{"id" => id}) do
    entry = Entries.get_entry!(id)
    changeset = Entries.change_entry(entry)
    render(conn, "edit.html", entry: entry, changeset: changeset)
  end

  def update(conn, %{"id" => id, "entry" => entry_params}) do
    entry = Entries.get_entry!(id)

    case Entries.update_entry(entry, entry_params) do
      {:ok, _entry} ->
        conn
        |> put_flash(:info, "Entry updated successfully.")
        |> redirect(to: event_entry_path(conn, :show, conn.assigns[:user]))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", entry: entry, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    entry = Entries.get_entry!(id)
    {:ok, _entry} = Entries.delete_entry(entry)

    conn
    |> put_flash(:info, "Entry deleted successfully.")
    |> redirect(to: event_entry_path(conn, :index, conn.assigns[:user]))
  end
end
