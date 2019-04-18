class User < ActiveRecord::Base
    has_one :team
    has_many :players, through: :team
    has_secure_password
    validates_presence_of :username, :email
    validates_uniqueness_of :username, :case_sensitive => false
    validates_uniqueness_of :email, :case_sensitive => false
end