class Favourite < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :project_id, uniqueness: {scope: :user_id}

  validate :no_owner_favouriting

  private

  def no_owner_favouriting
    project = Project.find(project_id)
    if project.user_id == user_id
      errors.add(:user_id, "Can't favourite your own project")
    end
  end
end
