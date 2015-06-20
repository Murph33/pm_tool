class Task < ActiveRecord::Base

  after_initialize :default_status
  belongs_to :user
  belongs_to :project

  validates :title, presence: true, uniqueness: { scope: :project }

  scope :done, -> { where(done: true) }
  def self.done
    where(done: true)
  end

  scope :undone, -> { where(done: false) }
  def self.undone
    where(done: false)
  end

  def default_status
    self.done ||= false
  end

end
