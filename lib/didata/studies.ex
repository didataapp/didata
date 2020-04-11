defmodule Didata.Studies do
  @moduledoc """
  The Studies context.
  """

  import Ecto.Query, warn: false
  alias Didata.Repo

  alias Didata.Studies.Objective

  @doc """
  Returns the list of objectives.

  ## Examples

      iex> list_objectives()
      [%Objective{}, ...]

  """
  def list_objectives do
    Repo.all(Objective)
  end

  @doc """
  Gets a single objective.

  Raises `Ecto.NoResultsError` if the Objective does not exist.

  ## Examples

      iex> get_objective!(123)
      %Objective{}

      iex> get_objective!(456)
      ** (Ecto.NoResultsError)

  """
  def get_objective!(id), do: Repo.get!(Objective, id)

  @doc """
  Creates a objective.

  ## Examples

      iex> create_objective(%{field: value})
      {:ok, %Objective{}}

      iex> create_objective(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_objective(attrs \\ %{}) do
    %Objective{}
    |> Objective.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a objective.

  ## Examples

      iex> update_objective(objective, %{field: new_value})
      {:ok, %Objective{}}

      iex> update_objective(objective, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_objective(%Objective{} = objective, attrs) do
    objective
    |> Objective.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a objective.

  ## Examples

      iex> delete_objective(objective)
      {:ok, %Objective{}}

      iex> delete_objective(objective)
      {:error, %Ecto.Changeset{}}

  """
  def delete_objective(%Objective{} = objective) do
    Repo.delete(objective)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking objective changes.

  ## Examples

      iex> change_objective(objective)
      %Ecto.Changeset{source: %Objective{}}

  """
  def change_objective(%Objective{} = objective) do
    Objective.changeset(objective, %{})
  end

  alias Didata.Studies.Area

  @doc """
  Returns the list of areas.

  ## Examples

      iex> list_areas()
      [%Area{}, ...]

  """
  def list_areas do
    Repo.all(Area)
  end

  @doc """
  Gets a single area.

  Raises `Ecto.NoResultsError` if the Area does not exist.

  ## Examples

      iex> get_area!(123)
      %Area{}

      iex> get_area!(456)
      ** (Ecto.NoResultsError)

  """
  def get_area!(id), do: Repo.get!(Area, id) |> Repo.preload(:objective)

  @doc """
  Creates a area.

  ## Examples

      iex> create_area(%{field: value})
      {:ok, %Area{}}

      iex> create_area(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_area(attrs \\ %{}) do
    %Area{}
    |> Area.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a area.

  ## Examples

      iex> update_area(area, %{field: new_value})
      {:ok, %Area{}}

      iex> update_area(area, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_area(%Area{} = area, attrs) do
    area
    |> Area.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a area.

  ## Examples

      iex> delete_area(area)
      {:ok, %Area{}}

      iex> delete_area(area)
      {:error, %Ecto.Changeset{}}

  """
  def delete_area(%Area{} = area) do
    Repo.delete(area)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking area changes.

  ## Examples

      iex> change_area(area)
      %Ecto.Changeset{source: %Area{}}

  """
  def change_area(%Area{} = area) do
    Area.changeset(area, %{})
  end

  alias Didata.Studies.Discipline

  @doc """
  Returns the list of disciplines.

  ## Examples

      iex> list_disciplines()
      [%Discipline{}, ...]

  """
  def list_disciplines do
    Repo.all(Discipline)
  end

  @doc """
  Gets a single discipline.

  Raises `Ecto.NoResultsError` if the Discipline does not exist.

  ## Examples

      iex> get_discipline!(123)
      %Discipline{}

      iex> get_discipline!(456)
      ** (Ecto.NoResultsError)

  """
  def get_discipline!(id), do: Repo.get!(Discipline, id) |> Repo.preload(:area)

  @doc """
  Creates a discipline.

  ## Examples

      iex> create_discipline(%{field: value})
      {:ok, %Discipline{}}

      iex> create_discipline(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_discipline(attrs \\ %{}) do
    %Discipline{}
    |> Discipline.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a discipline.

  ## Examples

      iex> update_discipline(discipline, %{field: new_value})
      {:ok, %Discipline{}}

      iex> update_discipline(discipline, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_discipline(%Discipline{} = discipline, attrs) do
    discipline
    |> Discipline.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a discipline.

  ## Examples

      iex> delete_discipline(discipline)
      {:ok, %Discipline{}}

      iex> delete_discipline(discipline)
      {:error, %Ecto.Changeset{}}

  """
  def delete_discipline(%Discipline{} = discipline) do
    Repo.delete(discipline)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking discipline changes.

  ## Examples

      iex> change_discipline(discipline)
      %Ecto.Changeset{source: %Discipline{}}

  """
  def change_discipline(%Discipline{} = discipline) do
    Discipline.changeset(discipline, %{})
  end
end
