defmodule Didata.Studies.Topic do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias Didata.Studies.{Discipline, Subtopic}

  schema "topics" do
    field :name, :string

    belongs_to :discipline, Discipline
    has_many :subtopics, Subtopic

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:name, :discipline_id])
    |> validate_required([:name, :discipline_id])
    |> unique_constraint(:name, name: :topics_name_discipline_id_index)
  end
end
