defmodule Didata.Repo.Migrations.CreateAreas do
  use Ecto.Migration

  def change do
    create table(:areas) do
      add :name, :string, null: false
      add :number, :integer, null: false
      add :objective_id, references(:objectives, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:areas, [:objective_id])
    create unique_index(:areas, [:name, :objective_id])
  end
end
