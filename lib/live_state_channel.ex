defmodule LiveStateChannel do
  defmacro __using__(_opts) do
    quote do
      def join(_channel, _payload, socket) do
        send(self(), :after_join)
        {:ok, socket}
      end

      def handle_info(:after_join, socket) do
        state = init(socket)
        push(socket, "state:change", state)
        {:noreply, socket |> assign(:state, state)}
      end

      def handle_in("lvs_evt:" <> event_name, payload, %{assigns: %{state: state}} = socket) do
        case handle_event(event_name, payload, state) do
          {:noreply, new_state} ->
            push(socket, "state:change", new_state)
            {:noreply, socket |> assign(:state, new_state)}
        end
      end
    end
  end
end
