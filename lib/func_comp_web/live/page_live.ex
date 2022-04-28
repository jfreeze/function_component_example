defmodule FuncCompWeb.PageLive do
  use Phoenix.LiveView

  alias FuncCompWeb.Live.Examples, as: E

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, list: ["a", "b", "c"])}
  end

  @impl true
  def render(%{live_action: live_action} = assigns) do
    IO.inspect(live_action, label: "\nlive_action")

    render_action(live_action, assigns)
  end

  def render(assigns) do
    ~H"""
    <E.links />
    """
  end

  def render_action(:a, assigns) do
    ~H"""
      <div class="flex">
        <E.links live_action={@live_action} />
        <h1>Function Component</h1>
      </div>
      <E.a list={@list}/>
    """
  end

  def render_action(:b, assigns) do
    ~H"""
    <div class="flex">
      <E.links live_action={@live_action} />
      <h1>Function Component w/ Parameter List</h1>
    </div>
    <E.b list={@list}/>
    """
  end

  def render_action(:c, assigns) do
    ~H"""
    <div class="flex">
      <E.links live_action={@live_action} />
      <h1>Function Component - Render @inner_block over list</h1>
    </div>
    <table>
      <E.c let={item} list={@list}>
        <tr><td><%= item %></td></tr>
      </E.c>
    </table>
    """
  end

  def render_action(:d, assigns) do
    ~H"""
    <div class="flex">
      <E.links live_action={@live_action} />
      <h1>Function Component w/ Custom Slot :header</h1>
    </div>
      <E.d let={row} list={@list}>
        <:header>
          This is a header
        </:header>
        <%= row %>
      </E.d>
    """
  end
end
