defmodule Didata.Studies.Area do
  use Ecto.Schema
  import Ecto.Changeset

  schema "areas" do
    field :name, :string
    field :number, :integer
    field :objective_id, :id

    timestamps()
  end

  @doc false
  def changeset(area, attrs) do
    area
    |> cast(attrs, [:name, :number])
    |> validate_required([:name, :number])
  end
end
