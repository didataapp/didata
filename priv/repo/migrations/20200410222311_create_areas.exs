defmodule Didata.Repo.Migrations.CreateAreas do
  use Ecto.Migration

  def change do
    create table(:areas) do
      add :name, :string
      add :number, :integer
      add :objective_id, references(:objectives, on_delete: :nothing)

      timestamps()
    end

    create index(:areas, [:objective_id])
  end
end
