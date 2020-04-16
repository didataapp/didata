defmodule Didata.Studies.Content do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias Didata.Studies.Subtopic

  schema "contents" do
    field :name, :string
    field :type, :string
    field :url, :string

    belongs_to :subtopic, Subtopic

    timestamps()
  end

  @doc false
  def changeset(content, attrs) do
    content
    |> cast(attrs, [:type, :name, :url, :subtopic_id])
    |> validate_required([:type, :name, :url])
  end
end
