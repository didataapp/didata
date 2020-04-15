defmodule Didata.Studies.Subtopic do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias Didata.Studies.Topic

  schema "subtopics" do
    field :name, :string

    belongs_to :topic, Topic

    timestamps()
  end

  @doc false
  def changeset(subtopic, attrs) do
    subtopic
    |> cast(attrs, [:name, :topic_id])
    |> validate_required([:name, :topic_id])
    |> unique_constraint(:name, name: :subtopics_name_topic_id_index)
  end
end
