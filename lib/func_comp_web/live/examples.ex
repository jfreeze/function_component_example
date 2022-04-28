defmodule FuncCompWeb.Live.Examples do
  use Phoenix.LiveComponent
  alias FuncCompWeb.Router.Helpers, as: Routes

  def a(assigns) do
    ~H"""
    <div>
      list: <%= inspect @list %>
    </div>
    <.i {assigns}/>
    """
  end

  def b(assigns) do
    ~H"""
    <%= for item <- @list do %>
      <div>
        <%= item %>
      </div>
    <% end %>
    <.i {assigns}/>
    """
  end

  def c(assigns) do
    ~H"""
    <%= for item <- @list do %>
      <%= render_slot @inner_block, item %>
    <% end %>
    <.i {assigns}/>
    """
  end

  def d(assigns) do
    ~H"""
    <div><%= render_slot(@header) %></div>
    <div>
      <table>
      <%= for item <- @list do %>
        <%= render_slot @inner_block, {:safe, "<tr><td>#{item}</td></tr>"} %>
      <% end %>
      </table>
    </div>
    <div><%= render_slot(@header) %></div>
    <.i {assigns}/>
    """
  end

  @spec i(map()) :: Phoenix.LiveView.Rendered.t()
  def i(assigns) do
    ~H"""
    <div class="inspect">
      <%= inspect assigns %>
    </div>
    """
  end

  @spec links(map) :: Phoenix.LiveView.Rendered.t()
  def links(%{live_action: :a} = assigns) do
    ~H"""
    <span>->
      <%= live_redirect "b", to: Routes.page_path(FuncCompWeb.Endpoint, :b) %>
    </span>
    """
  end

  def links(%{live_action: live_action} = assigns) do
    [position] = to_charlist(live_action)
    prev = String.to_atom(<<position - 1>>)
    next = String.to_atom(<<position + 1>>)

    assigns =
      assigns
      |> Map.put(:prev, prev)
      |> Map.put(:next, next)

    ~H"""
    <div class="noshrink">
      <span>
        <%= live_redirect @prev, to: Routes.page_path(FuncCompWeb.Endpoint, @prev) %>
      </span>&nbsp;&lt;-
      <span>->
        <%= live_redirect @next, to: Routes.page_path(FuncCompWeb.Endpoint, @next) %>
      </span>
    </div>
    """
  end

  def links(assigns) do
    ~H"""
    <span>
      <%= live_redirect :a, to: Routes.page_path(FuncCompWeb.Endpoint, :a) %>
    </span>
    """
  end
end
