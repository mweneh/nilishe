class RecipeController < ApplicationController
    before_action :is_authorized?

    def create_recipe
        recipe = @user_info.recipes.create(recipe_params)
        recipe.valid? ? recipe_created(recipe: recipe) : recipe_created(success: false)
      end
    
      def update_recipe
        recipe = @user_info.recipes.find_by(id: params[:id])
        recipe.update(recipe_params) ? recipe_updated(recipe: recipe) : recipe_updated(success: false)
      end
    
      def delete_recipe
        recipe = @user_info.recipes.find_by(id: params[:id])
        recipe ? recipe_deleted(success: recipe.destroy ) : recipe_deleted(success: false)
      end
    private

    def recipe_params
        params.permit(:title, :description)
    end

    def recipe_created(success: true, recipe: nil)
      app_response(
        status: success ? :created : :unprocessable_entity,
        message: success ? "Recipe has been created!" : "Could not create recipe",
        body: success ? { :recipe => serialize_data(recipe, RecipeSerializer)} : nil,
        serializer_key: :recipe
      )
    end
  
    def recipe_updated(success: true, recipe: nil)
      app_response(
        status: success ? :ok : :unprocessable_entity,
        message: success ? "Recipe has been updated!" : "Could not update recipe",
        body: success ? { :recipe => serialize_data(recipe, RecipeSerializer)} : nil,
        serializer_key: :recipe
      )
    end

    def recipe_deleted(success: true)
        app_response(
        status: success ? :ok : :unprocessable_entity,
        message: success ? "Recipe has been deleted!" : "Could not delete recipe"
        )
    end
end
