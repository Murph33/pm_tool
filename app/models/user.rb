class User < ActiveRecord::Base

  has_many :comments, dependent: :nullify
  has_many :projects, dependent: :nullify
  has_many :tasks, dependent: :nullify
  has_many :discussions, dependent: :nullify
  validates :first_name, presence: :true
  has_secure_password

end
