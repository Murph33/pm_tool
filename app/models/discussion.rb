class Discussion < ActiveRecord::Base

  validates_presence_of :title

  belongs_to :project
  has_many :comments, dependent: :destroy

end
