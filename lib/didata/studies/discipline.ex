defmodule Didata.Studies.Discipline do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias Didata.Studies.Area

  schema "disciplines" do
    field :name, :string

    belongs_to :area, Area

    timestamps()
  end

  @doc false
  def changeset(discipline, attrs) do
    discipline
    |> cast(attrs, [:name, :area_id])
    |> validate_required([:name, :area_id])
    |> unique_constraint(:name, name: :disciplines_name_area_id_index)
  end
end
