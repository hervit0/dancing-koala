defmodule KoalaWeb.EntryControllerTest do
  use KoalaWeb.ConnCase

  alias Koala.TestSupport.Factories.EventFactory
  alias Koala.TestSupport.Factories.EntryFactory

  @create_attrs %{customers_number: 42, price: 120.5}
  @update_attrs %{customers_number: 43, price: 456.7}
  @invalid_attrs %{customers_number: nil, price: nil}

  describe "GET /events/event.id/entries - Unauthenticated" do
    test "returns 401 - unauthenticated", %{conn: conn} do
      event = EventFactory.create()
      conn = get(conn, "/events/#{event.id}/entries")

      assert response(conn, 401) =~ "unauthenticated"
    end
  end

  @tag :authenticated
  describe "GET /events/event.id/entries" do
    test "lists all entries", %{conn: conn} do
      event = EventFactory.create()
      conn = get(conn, "/events/#{event.id}/entries")

      assert html_response(conn, 200) =~
               "These entries are for the event of the 2010-04-17 (some location)."
    end
  end

  @tag :authenticated
  describe "GET /events/event.id/entries/new" do
    test "renders form", %{conn: conn} do
      event = EventFactory.create()
      conn = get(conn, "/events/#{event.id}/entries/new")

      assert html_response(conn, 200) =~ "New Entry"
    end
  end

  describe "POST /events/event.id/entries" do
    @tag :authenticated
    test "redirects to show when data is valid", %{conn: conn} do
      event = EventFactory.create()
      post_response = post(conn, "/events/#{event.id}/entries", entry: @create_attrs)

      assert %{id: id, event_id: event_id} = redirected_params(post_response)
      assert redirected_to(post_response) == "/events/#{event_id}/entries/#{id}"

      get_response = get(conn, "/events/#{event.id}/entries/#{id}")
      assert html_response(get_response, 200) =~ "Show Entry"
    end

    @tag :authenticated
    test "renders errors when data is invalid", %{conn: conn} do
      event = EventFactory.create()
      conn = post(conn, "/events/#{event.id}/entries", entry: @invalid_attrs)

      assert html_response(conn, 200) =~ "New Entry"
    end
  end

  @tag :authenticated
  describe "GET /events/event.id/entries/entry.id/edit" do
    test "renders form for editing chosen entry", %{conn: conn} do
      {entry, event} = EntryFactory.create_with_event()
      conn = get(conn, "/events/#{event.id}/entries/#{entry.id}/edit")

      assert html_response(conn, 200) =~ "Edit Entry"
    end
  end

  describe "PUT /events/event.id/entries/entry.id" do
    @tag :authenticated
    test "redirects when data is valid", %{conn: conn} do
      {entry, event} = EntryFactory.create_with_event()
      put_response = put(conn, "/events/#{event.id}/entries/#{entry.id}", entry: @update_attrs)

      assert %{id: id, event_id: event_id} = redirected_params(put_response)
      assert redirected_to(put_response) == "/events/#{event_id}/entries/#{id}"

      get_response = get(conn, "/events/#{event.id}/entries/#{id}")
      assert html_response(get_response, 200) =~ "Show Entry"
    end

    @tag :authenticated
    test "renders errors when data is invalid", %{conn: conn} do
      {entry, event} = EntryFactory.create_with_event()
      conn = put(conn, "/events/#{event.id}/entries/#{entry.id}", entry: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Entry"
    end
  end

  @tag :authenticated
  describe "DELETE /events/event.id/entries/entry.id" do
    test "deletes chosen entry", %{conn: conn} do
      {entry, event} = EntryFactory.create_with_event()
      delete_response = delete(conn, "/events/#{event.id}/entries/#{entry.id}")

      assert %{event_id: event_id} = redirected_params(delete_response)
      assert event_id == event.id
      assert redirected_to(delete_response) == "/events/#{event.id}/entries"

      assert_error_sent(404, fn ->
        get(conn, "/events/#{event.id}/entries/#{entry.id}")
      end)
    end
  end
end
