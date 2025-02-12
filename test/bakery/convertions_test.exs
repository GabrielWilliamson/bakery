defmodule Bakery.ConvertionsTest do
  use Bakery.DataCase

  alias Bakery.Convertions

  describe "convertions" do
    alias Bakery.Convertions.Convertion

    import Bakery.ConvertionsFixtures

    @invalid_attrs %{conversion_factor: nil}

    test "list_convertions/0 returns all convertions" do
      convertion = convertion_fixture()
      assert Convertions.list_convertions() == [convertion]
    end

    test "get_convertion!/1 returns the convertion with given id" do
      convertion = convertion_fixture()
      assert Convertions.get_convertion!(convertion.id) == convertion
    end

    test "create_convertion/1 with valid data creates a convertion" do
      valid_attrs = %{conversion_factor: "120.5"}

      assert {:ok, %Convertion{} = convertion} = Convertions.create_convertion(valid_attrs)
      assert convertion.conversion_factor == Decimal.new("120.5")
    end

    test "create_convertion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Convertions.create_convertion(@invalid_attrs)
    end

    test "update_convertion/2 with valid data updates the convertion" do
      convertion = convertion_fixture()
      update_attrs = %{conversion_factor: "456.7"}

      assert {:ok, %Convertion{} = convertion} = Convertions.update_convertion(convertion, update_attrs)
      assert convertion.conversion_factor == Decimal.new("456.7")
    end

    test "update_convertion/2 with invalid data returns error changeset" do
      convertion = convertion_fixture()
      assert {:error, %Ecto.Changeset{}} = Convertions.update_convertion(convertion, @invalid_attrs)
      assert convertion == Convertions.get_convertion!(convertion.id)
    end

    test "delete_convertion/1 deletes the convertion" do
      convertion = convertion_fixture()
      assert {:ok, %Convertion{}} = Convertions.delete_convertion(convertion)
      assert_raise Ecto.NoResultsError, fn -> Convertions.get_convertion!(convertion.id) end
    end

    test "change_convertion/1 returns a convertion changeset" do
      convertion = convertion_fixture()
      assert %Ecto.Changeset{} = Convertions.change_convertion(convertion)
    end
  end
end
