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
      assert Studies.get_objective!(objective.id) == objective
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
      assert objective == Studies.get_objective!(objective.id)
    end

    test "delete_objective/1 deletes the objective" do
      objective = insert(:objective)
      assert {:ok, %Objective{}} = Studies.delete_objective(objective)
      assert_raise Ecto.NoResultsError, fn -> Studies.get_objective!(objective.id) end
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
end
