defmodule TodoApp.TodosTest do
  use TodoApp.DataCase

  alias TodoApp.Todos

  describe "tasks" do
    alias TodoApp.Todos.Task

    import TodoApp.TodosFixtures

    @invalid_attrs %{description: nil, done: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Todos.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Todos.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{description: "some description", done: true}

      assert {:ok, %Task{} = task} = Todos.create_task(valid_attrs)
      assert task.description == "some description"
      assert task.done == true
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{description: "some updated description", done: false}

      assert {:ok, %Task{} = task} = Todos.update_task(task, update_attrs)
      assert task.description == "some updated description"
      assert task.done == false
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_task(task, @invalid_attrs)
      assert task == Todos.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Todos.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Todos.change_task(task)
    end
  end

  describe "lists" do
    alias TodoApp.Todos.List

    import TodoApp.TodosFixtures

    @invalid_attrs %{name: nil, tags: nil}

    test "list_lists/0 returns all lists" do
      list = list_fixture()
      assert Todos.list_lists() == [list]
    end

    test "get_list!/1 returns the list with given id" do
      list = list_fixture()
      assert Todos.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      valid_attrs = %{name: "some name", tags: []}

      assert {:ok, %List{} = list} = Todos.create_list(valid_attrs)
      assert list.name == "some name"
      assert list.tags == []
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      list = list_fixture()
      update_attrs = %{name: "some updated name", tags: []}

      assert {:ok, %List{} = list} = Todos.update_list(list, update_attrs)
      assert list.name == "some updated name"
      assert list.tags == []
    end

    test "update_list/2 with invalid data returns error changeset" do
      list = list_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_list(list, @invalid_attrs)
      assert list == Todos.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      list = list_fixture()
      assert {:ok, %List{}} = Todos.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      list = list_fixture()
      assert %Ecto.Changeset{} = Todos.change_list(list)
    end
  end
end
