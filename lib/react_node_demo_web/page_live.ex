defmodule ReactNodeDemoWeb.PageLive do
  use ReactNodeDemoWeb, :live_view

  def mount(_, _, socket) do
    ReactNodeDemoWeb.Endpoint.subscribe("nodes")

    socket =
      socket
      |> assign(:nodes, [])
      |> assign(:edges, [])

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="w-full h-full">
      <div id="container" phx-hook="Nodes" class="w-full h-full" />
      <button phx-click="add_node" class="fixed bg-white	 top-0 left-0 rounded border p-1 m-2 ">+</button>
    </div>
    """
  end

  def handle_event("add_node", _value, %{assigns: %{nodes: nodes, edges: edges}} = socket) do
    node = new_node()
    edge = new_edge(nodes, node)
    nodes = nodes ++ [node]
    edges = edges ++ [edge]
    payload = %{nodes: nodes, edges: edges, socket_id: socket.id}

    socket =
      socket
      |> assign(:nodes, nodes)
      |> assign(:edges, edges)
      |> push_event("add_nodes", payload)

    ReactNodeDemoWeb.Endpoint.broadcast!("nodes", "added_node", payload)
    {:noreply, socket}
  end

  def handle_info(%{topic: "nodes", event: "added_node", payload: %{socket_id: socket_id}}, %{id: socket_id} = socket) do
    {:noreply, socket}
  end

  def handle_info(%{topic: "nodes", event: "added_node", payload: payload}, socket) do
    socket = push_event(socket, "add_nodes", payload)
    {:noreply, socket}
  end

  defp random_string, do: 10 |> :crypto.strong_rand_bytes() |> Base.encode32()

  defp new_node do
    id = random_string()

    %{
      id: id,
      data: %{label: id},
      position: %{x: Enum.random(1..1000), y: Enum.random(1..1000)}
    }
  end

  defp new_edge([], _), do: nil

  defp new_edge(nodes, node) do
    last_node = nodes |> Enum.take(-1) |> hd()
    %{id: "#{last_node.id}-to-#{node.id}", source: last_node.id, target: node.id}
  end
end
