defmodule TodoAppWeb.SessionHook do
  import Phoenix.LiveView

  def on_mount(_kind_of_user, _params, session, socket) do
    # IO.inspect(binding())

    user =
      session
      |> Map.get("user_token")
      |> TodoApp.Accounts.get_user_by_session_token()

    {:cont, assign(socket, :user, user)}
    # {:halt, socket}
  end
end
