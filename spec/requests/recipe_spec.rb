require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  # check for valid methods in the controller
  describe RecipeController, type: :controller do

    # check for existence of methods in the controller
    it { is_expected.to respond_to(:create_recipe) }
    it { is_expected.to respond_to(:update_recipe) }
    it { is_expected.to respond_to(:delete_recipe) }

  end
end
