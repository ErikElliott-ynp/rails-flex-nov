class User < ApplicationRecord
    validates :username, :email, presence: true
    validates :username, :uniqueness: true
end
