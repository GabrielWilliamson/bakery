defmodule Bakery.UnitsTest do
  use Bakery.DataCase

  alias Bakery.Units

  describe "units" do
    alias Bakery.Units.Unit

    import Bakery.UnitsFixtures

    @invalid_attrs %{name: nil, short: nil}

    test "list_units/0 returns all units" do
      unit = unit_fixture()
      assert Units.list_units() == [unit]
    end

    test "get_unit!/1 returns the unit with given id" do
      unit = unit_fixture()
      assert Units.get_unit!(unit.id) == unit
    end

    test "create_unit/1 with valid data creates a unit" do
      valid_attrs = %{name: "some name", short: "some short"}

      assert {:ok, %Unit{} = unit} = Units.create_unit(valid_attrs)
      assert unit.name == "some name"
      assert unit.short == "some short"
    end

    test "create_unit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Units.create_unit(@invalid_attrs)
    end

    test "update_unit/2 with valid data updates the unit" do
      unit = unit_fixture()
      update_attrs = %{name: "some updated name", short: "some updated short"}

      assert {:ok, %Unit{} = unit} = Units.update_unit(unit, update_attrs)
      assert unit.name == "some updated name"
      assert unit.short == "some updated short"
    end

    test "update_unit/2 with invalid data returns error changeset" do
      unit = unit_fixture()
      assert {:error, %Ecto.Changeset{}} = Units.update_unit(unit, @invalid_attrs)
      assert unit == Units.get_unit!(unit.id)
    end

    test "delete_unit/1 deletes the unit" do
      unit = unit_fixture()
      assert {:ok, %Unit{}} = Units.delete_unit(unit)
      assert_raise Ecto.NoResultsError, fn -> Units.get_unit!(unit.id) end
    end

    test "change_unit/1 returns a unit changeset" do
      unit = unit_fixture()
      assert %Ecto.Changeset{} = Units.change_unit(unit)
    end
  end
end
