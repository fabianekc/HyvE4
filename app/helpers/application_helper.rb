#encoding: utf-8
module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Hyve.me"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def reload_flash
    page.replace_html "flash_messages", :partial => 'layouts/flash'
  end
end
