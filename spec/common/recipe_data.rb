module RecipeTestData

    def recipe_data
      {
        title: "Ugali",
        description: "Boil water, add flour and stir to mix until firm"
      }
    end
  
    def invalid_recipe_data
      {
        title: "",
        description: "xyz"
      }
    end
  
    def dummy_recipe(user: nil)
      user.is_a?(User) ? user.recipes.create(recipe_data) : nil
    end
  end