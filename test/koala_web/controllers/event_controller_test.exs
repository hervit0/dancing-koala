defmodule KoalaWeb.EventControllerTest do
  use KoalaWeb.ConnCase

  alias Koala.Events
  alias Koala.TestSupport.Factories.EventFactory

  @create_attrs %{date: "2010-04-17 14:00:00.000000Z", expenses: 120.5, location: "Tabarnak"}
  @update_attrs %{date: "2011-05-18 15:01:01.000000Z", expenses: 456.7, location: "Dublin"}
  @invalid_attrs %{date: nil, expenses: nil, location: nil}

  def fixture(:event) do
    {:ok, event} = Events.create_event(@create_attrs)
    event
  end

  @tag :authenticated
  describe "index" do
    test "lists all events", %{conn: conn} do
      EventFactory.create(@create_attrs)
      conn = get(conn, event_path(conn, :index))

      response = html_response(conn, 200)
      assert response =~ "Tabarnak"
      assert response =~ "120.5"
    end
  end

  @tag :authenticated
  describe "new event" do
    test "renders form", %{conn: conn} do
      conn = get(conn, event_path(conn, :new))
      assert html_response(conn, 200) =~ "New Event"
    end
  end

  describe "create event" do
    @tag :authenticated
    test "redirects to show when data is valid", %{conn: conn} do
      post_response = post(conn, event_path(conn, :create), event: @create_attrs)

      assert %{id: id} = redirected_params(post_response)
      assert redirected_to(post_response) == event_path(post_response, :show, id)

      conn = get(conn, event_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Event"
    end

    @tag :authenticated
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, event_path(conn, :create), event: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Event"
    end
  end

  @tag :authenticated
  describe "edit event" do
    test "renders form for editing chosen event", %{conn: conn} do
      event = EventFactory.create()
      conn = get(conn, event_path(conn, :edit, event))

      assert html_response(conn, 200) =~ "Edit Event"
    end
  end

  describe "update event" do
    @tag :authenticated
    test "redirects when data is valid", %{conn: conn} do
      event = EventFactory.create()
      put_response = put(conn, event_path(conn, :update, event), event: @update_attrs)
      assert redirected_to(put_response) == event_path(put_response, :show, event)

      conn = get(conn, event_path(conn, :show, event))
      assert html_response(conn, 200) =~ "Dublin"
    end

    @tag :authenticated
    test "renders errors when data is invalid", %{conn: conn} do
      event = EventFactory.create()
      conn = put(conn, event_path(conn, :update, event), event: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Event"
    end
  end

  @tag :authenticated
  describe "delete event" do
    test "deletes chosen event", %{conn: conn} do
      event = EventFactory.create()
      delete_response = delete(conn, event_path(conn, :delete, event))
      assert redirected_to(delete_response) == event_path(delete_response, :index)

      assert_error_sent(404, fn ->
        get(conn, event_path(conn, :show, event))
      end)
    end
  end
end
