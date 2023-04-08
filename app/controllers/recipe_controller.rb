class RecipeController < ApplicationController
    before_action :is_authorized?
    
    private

def recipe_params
    params.permit(:title, :description)
end

def recipe_created(success: true, recipe: nil)
    app_response(
      status: success ? :created : :unprocessable_entity,
      message: success ? "Recipe has been created!" : "Could not create recipe",
      body: { :recipe => recipe}
    )
  end

  def recipe_updated(success: true, recipe: nil)
    app_response(
      status: success ? :ok : :unprocessable_entity,
      message: success ? "Recipe has been updated!" : "Could not update recipe",
      body: { :recipe => recipe}
    )
  end

  def recipe_deleted(success: true)
    app_response(
      status: success ? :ok : :unprocessable_entity,
      message: success ? "Recipe has been deleted!" : "Could not delete recipe"
    )
  end
end
