class Task < ActiveRecord::Base

  belongs_to :project

  validates :title, presence: true, uniqueness: { scope: :project }

end
