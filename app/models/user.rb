class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.create_unique_email
    User.create_unique_string + "@example.com"
  end
end
