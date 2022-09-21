defmodule TodoApp.Repo.Migrations.AddExpirationToTask do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add(:expiration, :naive_datetime)
    end
  end
end
