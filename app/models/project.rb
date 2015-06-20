class Project < ActiveRecord::Base

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


end
