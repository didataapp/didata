defmodule Didata.Repo.Migrations.CreateSubtopics do
  use Ecto.Migration

  def change do
    create table(:subtopics) do
      add :name, :string, null: false
      add :topic_id, references(:topics, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:subtopics, [:topic_id])
    create unique_index(:subtopics, [:name, :topic_id])
  end
end
