require 'rails_helper'

RSpec.describe User, type: :model do

  describe "model should have secure password" do
    it { should have_secure_password }
  end

end
