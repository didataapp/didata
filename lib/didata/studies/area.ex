defmodule Didata.Studies.Area do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias Didata.Studies.{
    Discipline,
    Objective
  }

  schema "areas" do
    field :name, :string
    field :number, :integer

    belongs_to :objective, Objective
    has_many :disciplines, Discipline

    timestamps()
  end

  @doc false
  def changeset(area, attrs) do
    area
    |> cast(attrs, [:name, :number, :objective_id])
    |> validate_required([:name, :number, :objective_id])
    |> unique_constraint(:name, name: :areas_name_objective_id_index)
  end
end
