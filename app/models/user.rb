class User < ActiveRecord::Base

  has_many :favourites, dependent: :destroy
  has_many :favourite_projects, through: :favourites, source: :project

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
    users.delete nil
    where('id not in (?)', users)
  end

  def favourited_by? project
    current_user.favourite_projects.include?(project)
  end

end
