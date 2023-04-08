require 'rails_helper'

RSpec.describe User, type: :model do

  describe "model should have secure password" do
    it { should have_secure_password }
  end
  
  describe "email data validations" do

    describe "email in-built validators" do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email) }
    end
  
    describe "email format custom validator" do
      it "should contain a valid email address" do
        email_error = "That email is not valid"
  
        invalid_mail = User.create(email: "a.com")
        valid_mail = User.create(email: "home@mail.com")
  
        expect(invalid_mail.errors[:base]).to include(email_error)
        expect(valid_mail.errors[:base]).to_not include(email_error)
      end
    end
  
  end

  describe "username data validations" do

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_length_of(:username).is_at_least(6) }
  
  end

end

