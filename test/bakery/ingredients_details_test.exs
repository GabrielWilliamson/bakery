defmodule Bakery.IngredientsDetailsTest do
  use Bakery.DataCase

  alias Bakery.IngredientsDetails

  describe "ingredients_details" do
    alias Bakery.IngredientsDetails.IngredientDetail

    import Bakery.IngredientsDetailsFixtures

    @invalid_attrs %{price: nil}

    test "list_ingredients_details/0 returns all ingredients_details" do
      ingredient_detail = ingredient_detail_fixture()
      assert IngredientsDetails.list_ingredients_details() == [ingredient_detail]
    end

    test "get_ingredient_detail!/1 returns the ingredient_detail with given id" do
      ingredient_detail = ingredient_detail_fixture()
      assert IngredientsDetails.get_ingredient_detail!(ingredient_detail.id) == ingredient_detail
    end

    test "create_ingredient_detail/1 with valid data creates a ingredient_detail" do
      valid_attrs = %{price: "120.5"}

      assert {:ok, %IngredientDetail{} = ingredient_detail} = IngredientsDetails.create_ingredient_detail(valid_attrs)
      assert ingredient_detail.price == Decimal.new("120.5")
    end

    test "create_ingredient_detail/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = IngredientsDetails.create_ingredient_detail(@invalid_attrs)
    end

    test "update_ingredient_detail/2 with valid data updates the ingredient_detail" do
      ingredient_detail = ingredient_detail_fixture()
      update_attrs = %{price: "456.7"}

      assert {:ok, %IngredientDetail{} = ingredient_detail} = IngredientsDetails.update_ingredient_detail(ingredient_detail, update_attrs)
      assert ingredient_detail.price == Decimal.new("456.7")
    end

    test "update_ingredient_detail/2 with invalid data returns error changeset" do
      ingredient_detail = ingredient_detail_fixture()
      assert {:error, %Ecto.Changeset{}} = IngredientsDetails.update_ingredient_detail(ingredient_detail, @invalid_attrs)
      assert ingredient_detail == IngredientsDetails.get_ingredient_detail!(ingredient_detail.id)
    end

    test "delete_ingredient_detail/1 deletes the ingredient_detail" do
      ingredient_detail = ingredient_detail_fixture()
      assert {:ok, %IngredientDetail{}} = IngredientsDetails.delete_ingredient_detail(ingredient_detail)
      assert_raise Ecto.NoResultsError, fn -> IngredientsDetails.get_ingredient_detail!(ingredient_detail.id) end
    end

    test "change_ingredient_detail/1 returns a ingredient_detail changeset" do
      ingredient_detail = ingredient_detail_fixture()
      assert %Ecto.Changeset{} = IngredientsDetails.change_ingredient_detail(ingredient_detail)
    end
  end
end
