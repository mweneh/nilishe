class User < ApplicationRecord
  has_many :recipes
  enum :u_type => { user: 0, admin: 1 }
  has_secure_password

  validates :email, { presence: true, uniqueness: true }
  validates :username, {presence: true, uniqueness: true, length: { minimum: 6 } }
  validate :mail_validity
  validate :password_valid?

  private

  # CUSTOM VALIDATIONS FOR DATA
  def mail_validity
    unless email.to_s.match(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/)
      errors.add(:base, "That email is not valid")
    end
  end

  def password_valid?
    unless password.to_s.match(/(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,}/)
      errors.add(:base, "That password is not strong enough")
    end
  end

end