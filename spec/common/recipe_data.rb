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
  
  end