defmodule Didata.Studies.Objective do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias Didata.Studies.Area

  schema "objectives" do
    field :name, :string

    has_many :areas, Area

    timestamps()
  end

  @doc false
  def changeset(objective, attrs) do
    objective
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
