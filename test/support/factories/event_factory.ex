defmodule Koala.TestSupport.Factories.EventFactory do
  alias Koala.Events

  @create_attrs %{
    date: "2010-04-17 14:00:00.000000Z",
    expenses: 120.5,
    location: "some location"
  }

  def create(attrs \\ @create_attrs) do
    {:ok, event} = Events.create_event(attrs)
    event
  end
end
