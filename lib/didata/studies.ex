defmodule Didata.Studies do
  import Ecto.Query

  @moduledoc """
  The Studies context.
  """

  import Ecto.Query, warn: false
  alias Didata.Repo

  alias Didata.Studies.{
    Area,
    Content,
    Discipline,
    Objective,
    Topic,
    Subtopic
  }

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
  def get_objective(objective_id) do
    from(
      objective in Objective,
      left_join: area in Area, on: area.objective_id == objective.id,
      where: objective.id == ^objective_id,
      preload: [:areas]
    ) |> Repo.one()
  end

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

  def get_area(area_id) do
    from(
      area in Area,
      left_join: discipline in Discipline, on: discipline.area_id == area.id,
      where: area.id == ^area_id,
      preload: [:disciplines]
    ) |> Repo.one()
  end

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
  def get_discipline(discipline_id) do
    from(
      discipline in Discipline,
      left_join: topic in Topic, on: topic.discipline_id == discipline.id,
      where: discipline.id == ^discipline_id,
      preload: [:topics]
    ) |> Repo.one()
  end

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

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list_topics()
      [%Topic{}, ...]

  """
  def list_topics do
    Repo.all(Topic) |> Repo.preload(discipline: [area: [:objective]])
  end

  @doc """
  Gets a single topic.

  Raises `Ecto.NoResultsError` if the Topic does not exist.

  ## Examples

      iex> get_topic!(123)
      %Topic{}

      iex> get_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_topic(topic_id) do
    from(
      topic in Topic,
      where: topic.id == ^topic_id,
      preload: [:subtopics]
    ) |> Repo.one()
  end

  def get_topic!(id), do: Repo.get!(Topic, id) |> Repo.preload(discipline: [area: [:objective]])

  @doc """
  Creates a topic.

  ## Examples

      iex> create_topic(%{field: value})
      {:ok, %Topic{}}

      iex> create_topic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a topic.

  ## Examples

      iex> update_topic(topic, %{field: new_value})
      {:ok, %Topic{}}

      iex> update_topic(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a topic.

  ## Examples

      iex> delete_topic(topic)
      {:ok, %Topic{}}

      iex> delete_topic(topic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking topic changes.

  ## Examples

      iex> change_topic(topic)
      %Ecto.Changeset{source: %Topic{}}

  """
  def change_topic(%Topic{} = topic) do
    Topic.changeset(topic, %{})
  end

  @doc """
  Returns the list of subtopics.

  ## Examples

      iex> list_subtopics()
      [%Subtopic{}, ...]

  """
  def list_subtopics do
    Repo.all(Subtopic)
  end

  @doc """
  Gets a single subtopic.

  Raises `Ecto.NoResultsError` if the Subtopic does not exist.

  ## Examples

      iex> get_subtopic!(123)
      %Subtopic{}

      iex> get_subtopic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subtopic(subtopic_id) do
    from(
      subtopic in Subtopic,
      where: subtopic.id == ^subtopic_id,
      preload: [:contents]
    ) |> Repo.one()
  end

  def get_subtopic!(id), do: Repo.get!(Subtopic, id) |> Repo.preload(:topic)

  @doc """
  Creates a subtopic.

  ## Examples

      iex> create_subtopic(%{field: value})
      {:ok, %Subtopic{}}

      iex> create_subtopic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_subtopic(attrs \\ %{}) do
    %Subtopic{}
    |> Subtopic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a subtopic.

  ## Examples

      iex> update_subtopic(subtopic, %{field: new_value})
      {:ok, %Subtopic{}}

      iex> update_subtopic(subtopic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subtopic(%Subtopic{} = subtopic, attrs) do
    subtopic
    |> Subtopic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a subtopic.

  ## Examples

      iex> delete_subtopic(subtopic)
      {:ok, %Subtopic{}}

      iex> delete_subtopic(subtopic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subtopic(%Subtopic{} = subtopic) do
    Repo.delete(subtopic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking subtopic changes.

  ## Examples

      iex> change_subtopic(subtopic)
      %Ecto.Changeset{source: %Subtopic{}}

  """
  def change_subtopic(%Subtopic{} = subtopic) do
    Subtopic.changeset(subtopic, %{})
  end

  @doc """
  Returns the list of contents.

  ## Examples

      iex> list_contents()
      [%Content{}, ...]

  """
  def list_contents do
    Repo.all(Content)
  end

  @doc """
  Gets a single content.

  Raises `Ecto.NoResultsError` if the Content does not exist.

  ## Examples

      iex> get_content!(123)
      %Content{}

      iex> get_content!(456)
      ** (Ecto.NoResultsError)

  """
  def get_content!(id), do: Repo.get!(Content, id) |> Repo.preload(:subtopic)

  @doc """
  Creates a content.

  ## Examples

      iex> create_content(%{field: value})
      {:ok, %Content{}}

      iex> create_content(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_content(attrs \\ %{}) do
    %Content{}
    |> Content.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a content.

  ## Examples

      iex> update_content(content, %{field: new_value})
      {:ok, %Content{}}

      iex> update_content(content, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_content(%Content{} = content, attrs) do
    content
    |> Content.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a content.

  ## Examples

      iex> delete_content(content)
      {:ok, %Content{}}

      iex> delete_content(content)
      {:error, %Ecto.Changeset{}}

  """
  def delete_content(%Content{} = content) do
    Repo.delete(content)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking content changes.

  ## Examples

      iex> change_content(content)
      %Ecto.Changeset{source: %Content{}}

  """
  def change_content(%Content{} = content) do
    Content.changeset(content, %{})
  end

  @doc """
  Returns a list of valid content types.

  ## Examples

      iex> content_types()
      ["video", "text"]
  """
  def content_types do
    ["video", "text"]
  end
end
