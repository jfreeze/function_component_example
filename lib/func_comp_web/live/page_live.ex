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

  def render_action(nil, assigns) do
    ~H"""
    Example: <E.links />
    """
  end

  def render_action(:a, assigns) do
    ~H"""
      <.title live_action={@live_action}>A: Function Component</.title>
      <p>Example passing a parameter to a FC</p>
      <E.a list={@list}/>
    """
  end

  def render_action(:b, assigns) do
    ~H"""
    <.title live_action={@live_action}>B: Function Component w/ Parameter List</.title>
    <p>Example of a FC using a parameter (e.g., a list) to create markup.</p>

    <E.b list={@list}/>
    """
  end

  def render_action(:c, assigns) do
    ~H"""
    <.title live_action={@live_action}>C: Function Component - Render @inner_block over list</.title>
    <p>Using the callback feature of slots to pass data from the FC markup context.</p>
    <table>
      <E.c let={item} list={@list}>
        <tr><td><%= item %></td></tr>
      </E.c>
    </table>
    """
  end

  def render_action(:d, assigns) do
    ~H"""
    <.title live_action={@live_action}>D: Function Component w/ Custom Slot :header</.title>
    <p>Combining custom slots with a FC to create a table.</p>
    <E.d let={row} list={@list}>
      <:header>
        This is a header
      </:header>
      <%= row %>
    </E.d>
    """
  end

  def title(assigns) do
    ~H"""
    <div class="flex">
      <E.links live_action={@live_action} />
      <h1><%= render_slot @inner_block %></h1>
    </div>
    """
  end
end
