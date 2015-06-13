class Project < ActiveRecord::Base

  has_many :tasks, dependent: :destroy
  has_many :discussions, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  def self.search term
    Project.where("title ILIKE :term OR description ILIKE :term", {term: "%#{term}%"})
  end

end
