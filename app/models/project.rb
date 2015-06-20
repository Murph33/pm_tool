class Project < ActiveRecord::Base

  has_many :favourites, dependent: :destroy
  has_many :favouriting_users, through: :favourites, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :collaborations, dependent: :destroy
  has_many :collaborating_users, through: :collaborations, source: :user

  has_many :tasks, dependent: :destroy
  has_many :discussions, dependent: :destroy

  belongs_to :user

  validates :title, presence: true, uniqueness: true

  def self.search term
    Project.where("title ILIKE :term OR description ILIKE :term", {term: "%#{term}%"})
  end

  def tasks_done
    tasks.done
  end

  def tasks_undone
    tasks.undone
  end

  def favourited_by? user
    favourites.where(user: user).present?
  end

  def favourite_for user
    favourites.find_by_user_id user
  end


end
