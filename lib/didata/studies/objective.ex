defmodule Didata.Studies.Objective do
  use Ecto.Schema
  import Ecto.Changeset

  schema "objectives" do
    field :name, :string

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
