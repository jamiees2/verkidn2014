class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects
  has_many :assignments
  has_many :tasks, through: :assignments
  has_many :work_logs, through: :assignments
  belongs_to :role
  def role? ( role )
    return self.role.name == role.to_s.camelize
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.create_unique_email
    User.create_unique_string + "@example.com"
  end
end
