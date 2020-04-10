defmodule Didata.Repo.Migrations.CreateObjectives do
  use Ecto.Migration

  def change do
    create table(:objectives) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:objectives, [:name])
  end
end
