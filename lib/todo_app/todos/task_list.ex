defmodule TodoApp.Todos.TaskList do
  use Ecto.Schema
  import Ecto.Changeset

  alias TodoApp.Todos.List
  alias TodoApp.Todos.Task

  schema "tasks_lists" do
    belongs_to :task, Task
    belongs_to :list, List
    timestamps()
  end

  def changeset(struct, params) do
    IO.inspect(binding())

    struct
    |> cast(params, [])
  end
end
