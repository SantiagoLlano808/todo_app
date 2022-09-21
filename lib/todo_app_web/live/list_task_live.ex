defmodule TodoAppWeb.ListTaskLive do
  use TodoAppWeb, :live_view

  alias TodoApp.Todos.List
  alias TodoApp.Todos.Task
  alias TodoApp.Todos

  def mount(_params, _session, socket) do
    changeset = Todos.change_list(%List{})
    changeset_task = Todos.change_task(%Task{})

    socket =
      socket
      |> assign(
        changeset: changeset,
        changeset_task: changeset_task,
        tasks: []
      )

    {:ok, socket}
  end

  def handle_event("validate_task", %{"task" => task_params}, %{assigns: %{user: user}} = socket) do
    changeset_task =
      %Task{}
      |> Todos.change_task(Map.put(task_params, "user_id", user.id))
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, :changeset_task, changeset_task)}
  end

  def handle_event("add_task", %{"task" => task_params}, %{assigns: %{user: user}} = socket) do
    socket =
      socket
      |> assign(
        tasks: [Map.put(task_params, "user_id", user.id) | socket.assigns.tasks],
        changeset_task: Todos.change_task(%Task{})
      )

    {:noreply, socket}
  end

  def handle_event("validate", %{"list" => list_params}, %{assigns: %{user: user}} = socket) do
    changeset =
      %List{}
      |> Todos.change_list(Map.put(list_params, "user_id", user.id))
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"list" => list_params}, %{assigns: %{user: user}} = socket) do
    list_params
    |> Map.put("user_id", user.id)
    |> Map.put("tasks", socket.assigns.tasks)
    |> Todos.create_list_with_tasks()
    |> case do
      {:ok, list} ->
        socket =
          socket
          |> put_flash(:info, "A list has been created")
          |> redirect(to: Routes.list_path(socket, :show, list))

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
