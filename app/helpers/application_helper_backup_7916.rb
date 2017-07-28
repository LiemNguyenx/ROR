# module
module ApplicationHelper
  # Return the full title
  def full_title page_title = ""
    base_title = I18n.t("base_title")
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
