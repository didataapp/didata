defmodule Didata.Repo.Migrations.CreateDisciplines do
  use Ecto.Migration

  def change do
    create table(:disciplines) do
      add :name, :string
      add :area_id, references(:areas, on_delete: :nothing)

      timestamps()
    end

    create index(:disciplines, [:area_id])
    create unique_index(:disciplines, [:name, :area_id])
  end
end
