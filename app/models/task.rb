class Task < ActiveRecord::Base

  after_initialize :default_status
  belongs_to :user
  belongs_to :project

  validates :title, presence: true, uniqueness: { scope: :project }

  def default_status
    self.done ||= false
  end

end
