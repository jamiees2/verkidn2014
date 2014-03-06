class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :work
  has_many :assignments
  has_many :work_parts, through: :assignments
  has_and_belongs_to_many :roles
  def role? ( role )
    return !! self.roles.find_by_name( role.to_s.camelize )
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.create_unique_email
    User.create_unique_string + "@example.com"
  end
end
