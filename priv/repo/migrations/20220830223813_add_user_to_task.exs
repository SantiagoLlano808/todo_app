defmodule TodoApp.Repo.Migrations.AddUserToTask do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add(:user_id, references(:users), null: false)
    end
  end
end
