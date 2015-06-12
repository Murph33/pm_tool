module ApplicationHelper

  def formatted_date date
    date.strftime("%Y-%B-%d %H:00")
  end

end
