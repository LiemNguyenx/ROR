# module
module ApplicationHelper
<<<<<<< HEAD
=======
  # Return the full title
  def full_title page_title = ""
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
>>>>>>> rails-flavored-ruby
end
