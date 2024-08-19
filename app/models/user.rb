class User < ApplicationRecord
    has_many :api_keys
  
    validates :email, presence: true, uniqueness: true
    validates :encrypted_password, presence: true
end
