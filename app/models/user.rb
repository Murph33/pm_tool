class User < ActiveRecord::Base

  has_many :collaborations, dependent: :destroy
  has_many :collaborated_projects, through: :collaborations, source: :project

  has_many :comments, dependent: :nullify
  has_many :projects, dependent: :nullify
  has_many :tasks, dependent: :nullify
  has_many :discussions, dependent: :nullify
  validates :first_name, presence: :true
  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.exclude_users users
    where('id not in (?)', users)
  end

end
