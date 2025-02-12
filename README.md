# Bakery

_Project in development, will be available soon_

**It is an open source project. Created to improve the accounting process in bakeries.Is the open source project, created for better accountain process in bakeries**

## Building with:

![Elixir](https://img.shields.io/badge/Elixir-4B275F?style=flat&logo=elixir)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-2F5C82?style=flat&logo=postgresql)
![Phoenix](https://img.shields.io/badge/Phoenix-FF7200?style=flat&logo=elixir)

## todo list

- update ingredients details where price updated
- remove ingredients if no recipe uses them
- add crud recipes
- add email verification


## commands list

```bash
mix phx.gen.auth Accounts User users
```

```bash
mix phx.gen.html Units Unit units name:string short:string
```

```bash
mix phx.gen.html Convertions Convertion convertions conversion_factor:decimal from_unit_id:references:units to_unit_id:references:units
```

```bash
mix phx.gen.html Ingredients Ingredient ingredients name:string price:decimal
```

```bash
mix phx.gen.html IngredientsDetails IngredientDetail ingredients_details price:decimal unit_id:references:units ingredient_id:references:ingredients
```
