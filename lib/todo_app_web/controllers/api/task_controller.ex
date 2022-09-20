defmodule TodoAppWeb.API.TaskController do
  use TodoAppWeb, :controller

  alias TodoApp.Todos

  def index(conn, _params) do
    tasks = Todos.list_tasks()

    conn
    |> put_resp_header("Content-Type", "json++")
    |> put_status(:unauthorized)
    |> json(%{tasks: tasks})
  end
end
