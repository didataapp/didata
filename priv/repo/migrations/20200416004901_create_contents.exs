defmodule Didata.Repo.Migrations.CreateContents do
  use Ecto.Migration

  def up do
    execute("CREATE TYPE content_type AS ENUM ('video', 'text')")

    create table(:contents) do
      add :type, :content_type, null: false
      add :name, :string, null: false
      add :url, :string, null: false
      add :subtopic_id, references(:subtopics, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:contents, [:subtopic_id])
  end

  def down do
    drop index(:contents, [:subtopic_id])
    drop table(:contents)
    execute("DROP TYPE content_type")
  end
end
