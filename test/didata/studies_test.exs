defmodule Didata.StudiesTest do
  use Didata.DataCase

  alias Didata.{Repo, Studies}

  describe "objectives" do
    alias Didata.Studies.Objective

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    test "list_objectives/0 returns all objectives" do
      objective = insert(:objective)
      assert Studies.list_objectives() == [objective]
    end

    test "get_objective!/1 returns the objective with given id" do
      objective = insert(:objective)
      assert Studies.get_objective(objective.id).name == objective.name
    end

    test "create_objective/1 with valid data creates a objective" do
      assert {:ok, %Objective{} = objective} = Studies.create_objective(@valid_attrs)
      assert objective.name == "some name"
    end

    test "create_objective/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Studies.create_objective(@invalid_attrs)
    end

    test "update_objective/2 with valid data updates the objective" do
      objective = insert(:objective)
      assert {:ok, %Objective{} = objective} = Studies.update_objective(objective, @update_attrs)
      assert objective.name == "some updated name"
    end

    test "update_objective/2 with invalid data returns error changeset" do
      objective = insert(:objective)
      assert {:error, %Ecto.Changeset{}} = Studies.update_objective(objective, @invalid_attrs)
      assert objective.name == Studies.get_objective(objective.id).name
    end

    test "delete_objective/1 deletes the objective" do
      objective = insert(:objective)
      assert {:ok, %Objective{}} = Studies.delete_objective(objective)
      assert Studies.get_objective(objective.id) == nil
    end

    test "change_objective/1 returns a objective changeset" do
      objective = insert(:objective)
      assert %Ecto.Changeset{} = Studies.change_objective(objective)
    end
  end

  describe "areas" do
    alias Didata.Studies.Area

    @valid_attrs %{name: "some name", number: 42}
    @update_attrs %{name: "some updated name", number: 43}
    @invalid_attrs %{name: nil, number: nil}

    test "list_areas/0 returns all areas" do
      area = insert(:area)
      assert Studies.list_areas() |> Repo.preload(:objective) == [area]
    end

    test "get_area!/1 returns the area with given id" do
      area = insert(:area) |> Repo.preload(:objective)
      assert Studies.get_area!(area.id) == area
    end

    test "create_area/1 with valid data creates a area" do
      objective = insert(:objective)

      assert {:ok, %Area{} = area} =
               Studies.create_area(Map.merge(@valid_attrs, %{objective_id: objective.id}))

      assert area.name == "some name"
      assert area.number == 42
    end

    test "create_area/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Studies.create_area(@invalid_attrs)
    end

    test "update_area/2 with valid data updates the area" do
      area = insert(:area)
      assert {:ok, %Area{} = area} = Studies.update_area(area, @update_attrs)
      assert area.name == "some updated name"
      assert area.number == 43
    end

    test "update_area/2 with invalid data returns error changeset" do
      area = insert(:area)
      assert {:error, %Ecto.Changeset{}} = Studies.update_area(area, @invalid_attrs)
      assert area == Studies.get_area!(area.id)
    end

    test "delete_area/1 deletes the area" do
      area = insert(:area)
      assert {:ok, %Area{}} = Studies.delete_area(area)
      assert_raise Ecto.NoResultsError, fn -> Studies.get_area!(area.id) end
    end

    test "change_area/1 returns a area changeset" do
      area = insert(:area)
      assert %Ecto.Changeset{} = Studies.change_area(area)
    end
  end

  describe "disciplines" do
    alias Didata.Studies.Discipline

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    test "list_disciplines/0 returns all disciplines" do
      discipline = insert(:discipline)
      assert Enum.map(Studies.list_disciplines(), fn d -> d.id end) == [discipline.id]
    end

    test "get_discipline!/1 returns the discipline with given id" do
      discipline = insert(:discipline)
      assert Studies.get_discipline!(discipline.id).name == discipline.name
    end

    test "create_discipline/1 with valid data creates a discipline" do
      area = insert(:area)

      assert {:ok, %Discipline{} = discipline} =
               Studies.create_discipline(Map.merge(@valid_attrs, %{area_id: area.id}))

      assert discipline.name == "some name"
    end

    test "create_discipline/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Studies.create_discipline(@invalid_attrs)
    end

    test "update_discipline/2 with valid data updates the discipline" do
      discipline = insert(:discipline)

      assert {:ok, %Discipline{} = discipline} =
               Studies.update_discipline(discipline, @update_attrs)

      assert discipline.name == "some updated name"
    end

    test "update_discipline/2 with invalid data returns error changeset" do
      discipline = insert(:discipline)
      assert {:error, %Ecto.Changeset{}} = Studies.update_discipline(discipline, @invalid_attrs)
      assert discipline.name == Studies.get_discipline!(discipline.id).name
    end

    test "delete_discipline/1 deletes the discipline" do
      discipline = insert(:discipline)
      assert {:ok, %Discipline{}} = Studies.delete_discipline(discipline)
      assert_raise Ecto.NoResultsError, fn -> Studies.get_discipline!(discipline.id) end
    end

    test "change_discipline/1 returns a discipline changeset" do
      discipline = insert(:discipline)
      assert %Ecto.Changeset{} = Studies.change_discipline(discipline)
    end
  end

  describe "topics" do
    alias Didata.Studies.Topic

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    test "list_topics/0 returns all topics" do
      topic = insert(:topic)
      assert Studies.list_topics() == [topic]
    end

    test "get_topic!/1 returns the topic with given id" do
      topic = insert(:topic)
      assert Studies.get_topic!(topic.id) == topic
    end

    test "create_topic/1 with valid data creates a topic" do
      discipline = insert(:discipline)

      assert {:ok, %Topic{} = topic} =
               Studies.create_topic(Map.merge(@valid_attrs, %{discipline_id: discipline.id}))

      assert topic.name == "some name"
    end

    test "create_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Studies.create_topic(@invalid_attrs)
    end

    test "update_topic/2 with valid data updates the topic" do
      topic = insert(:topic)
      assert {:ok, %Topic{} = topic} = Studies.update_topic(topic, @update_attrs)
      assert topic.name == "some updated name"
    end

    test "update_topic/2 with invalid data returns error changeset" do
      topic = insert(:topic)
      assert {:error, %Ecto.Changeset{}} = Studies.update_topic(topic, @invalid_attrs)
      assert topic == Studies.get_topic!(topic.id)
    end

    test "delete_topic/1 deletes the topic" do
      topic = insert(:topic)
      assert {:ok, %Topic{}} = Studies.delete_topic(topic)
      assert_raise Ecto.NoResultsError, fn -> Studies.get_topic!(topic.id) end
    end

    test "change_topic/1 returns a topic changeset" do
      topic = insert(:topic)
      assert %Ecto.Changeset{} = Studies.change_topic(topic)
    end
  end

  describe "subtopics" do
    alias Didata.Studies.Subtopic

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    test "list_subtopics/0 returns all subtopics" do
      subtopic = insert(:subtopic)
      assert Enum.map(Studies.list_subtopics(), & &1.name) == [subtopic.name]
    end

    test "get_subtopic!/1 returns the subtopic with given id" do
      subtopic = insert(:subtopic)
      assert Studies.get_subtopic!(subtopic.id).name == subtopic.name
    end

    test "create_subtopic/1 with valid data creates a subtopic" do
      topic = insert(:topic)

      assert {:ok, %Subtopic{} = subtopic} =
               Studies.create_subtopic(Map.merge(@valid_attrs, %{topic_id: topic.id}))

      assert subtopic.name == "some name"
    end

    test "create_subtopic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Studies.create_subtopic(@invalid_attrs)
    end

    test "update_subtopic/2 with valid data updates the subtopic" do
      subtopic = insert(:subtopic)
      assert {:ok, %Subtopic{} = subtopic} = Studies.update_subtopic(subtopic, @update_attrs)
      assert subtopic.name == "some updated name"
    end

    test "update_subtopic/2 with invalid data returns error changeset" do
      subtopic = insert(:subtopic)
      assert {:error, %Ecto.Changeset{}} = Studies.update_subtopic(subtopic, @invalid_attrs)
      assert subtopic.name == Studies.get_subtopic!(subtopic.id).name
    end

    test "delete_subtopic/1 deletes the subtopic" do
      subtopic = insert(:subtopic)
      assert {:ok, %Subtopic{}} = Studies.delete_subtopic(subtopic)
      assert_raise Ecto.NoResultsError, fn -> Studies.get_subtopic!(subtopic.id) end
    end

    test "change_subtopic/1 returns a subtopic changeset" do
      subtopic = insert(:subtopic)
      assert %Ecto.Changeset{} = Studies.change_subtopic(subtopic)
    end
  end

  describe "contents" do
    alias Didata.Studies.Content

    @valid_attrs %{name: "some name", type: "video", url: "some url"}
    @update_attrs %{name: "some updated name", type: "text", url: "some updated url"}
    @invalid_attrs %{name: nil, type: nil, url: nil}

    test "list_contents/0 returns all contents" do
      content = insert(:content)
      assert Enum.map(Studies.list_contents(), & &1.name) == [content.name]
    end

    test "get_content!/1 returns the content with given id" do
      content = insert(:content)
      assert Studies.get_content!(content.id).name == content.name
    end

    test "create_content/1 with valid data creates a content" do
      subtopic = insert(:subtopic)

      assert {:ok, %Content{} = content} =
               Studies.create_content(Map.merge(@valid_attrs, %{subtopic_id: subtopic.id}))

      assert content.name == "some name"
      assert content.type == "video"
      assert content.url == "some url"
    end

    test "create_content/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Studies.create_content(@invalid_attrs)
    end

    test "update_content/2 with valid data updates the content" do
      content = insert(:content)
      assert {:ok, %Content{} = content} = Studies.update_content(content, @update_attrs)
      assert content.name == "some updated name"
      assert content.type == "text"
      assert content.url == "some updated url"
    end

    test "update_content/2 with invalid data returns error changeset" do
      content = insert(:content)
      assert {:error, %Ecto.Changeset{}} = Studies.update_content(content, @invalid_attrs)
      assert content.name == Studies.get_content!(content.id).name
    end

    test "delete_content/1 deletes the content" do
      content = insert(:content)
      assert {:ok, %Content{}} = Studies.delete_content(content)
      assert_raise Ecto.NoResultsError, fn -> Studies.get_content!(content.id) end
    end

    test "change_content/1 returns a content changeset" do
      content = insert(:content)
      assert %Ecto.Changeset{} = Studies.change_content(content)
    end
  end
end
