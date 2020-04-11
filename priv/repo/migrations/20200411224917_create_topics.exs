defmodule Didata.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :name, :string, null: false
      add :discipline_id, references(:disciplines, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:topics, [:discipline_id])
    create unique_index(:topics, [:name, :discipline_id])
  end
end
