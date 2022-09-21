defmodule TodoApp.Todos.List do
  use Ecto.Schema
  import Ecto.Changeset

  alias TodoApp.Accounts.User
  alias TodoApp.Todos.TaskList
  alias TodoApp.Todos.Task

  schema "lists" do
    field :name, :string
    field :tags, {:array, :string}
    belongs_to :user, User

    has_many :collaborators, User

    many_to_many :tasks, Task, join_through: TaskList

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name, :tags, :user_id])
    |> validate_required([:name, :tags, :user_id])
    |> validate_length(:name, min: 5)
    |> foreign_key_constraint(:user_id)
    |> cast_assoc(:tasks)
  end

  @doc false
  def changeset_with_tasks(list, attrs) do
    list
    |> changeset(attrs)
    |> validate_length(:tasks, min: 1)
  end
end
