defmodule KoalaWeb.EntryController do
  use KoalaWeb, :controller

  import Ecto

  alias Koala.Entries
  alias Koala.Entries.Entry
  alias Koala.Events.Event
  alias Koala.Repo

  plug(:assign_event)

  defp assign_event(conn, _opts) do
    invalid_event = fn conn ->
      conn
      |> put_flash(:error, "Invalid event!")
      |> redirect(to: page_path(conn, :index))
      |> halt
    end

    case conn.params do
      %{"event_id" => event_id} ->
        case Repo.get(Event, event_id) do
          nil -> invalid_event.(conn)
          event -> assign(conn, :event, event)
        end

      _ ->
        invalid_event.(conn)
    end
  end

  def index(conn, _params) do
    entries = Repo.all(assoc(conn.assigns[:event], :entries))
    render(conn, "index.html", entries: entries)
  end

  def new(conn, _params) do
    changeset =
      conn.assigns[:event]
      |> build_assoc(:entries)
      |> Entry.changeset(%{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"entry" => entry_params}) do
    changeset =
      conn.assigns[:event]
      |> build_assoc(:entries)
      |> Entry.changeset(entry_params)

    case Repo.insert(changeset) do
      {:ok, entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: event_entry_path(conn, :show, conn.assigns[:event], entry))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    entry = Repo.get!(assoc(conn.assigns[:event], :entries), id)
    render(conn, "show.html", entry: entry)
  end

  def edit(conn, %{"id" => id}) do
    entry = Repo.get!(assoc(conn.assigns[:event], :entries), id)
    changeset = Entry.changeset(entry)
    render(conn, "edit.html", entry: entry, changeset: changeset)
  end

  def update(conn, %{"id" => id, "entry" => entry_params}) do
    entry = Repo.get!(assoc(conn.assigns[:event], :entries), id)
    changeset = Entry.changeset(entry, entry_params)

    case Repo.update(changeset) do
      {:ok, entry} ->
        conn
        |> put_flash(:info, "Entry updated successfully.")
        |> redirect(to: event_entry_path(conn, :show, conn.assigns[:event], entry))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", entry: entry, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    entry = Repo.get!(assoc(conn.assigns[:event], :entries), id)
    {:ok, _entry} = Entries.delete_entry(entry)

    conn
    |> put_flash(:info, "Entry deleted successfully.")
    |> redirect(to: event_entry_path(conn, :index, conn.assigns[:event]))
  end
end
