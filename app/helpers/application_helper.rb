module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end
  
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "AleSpace"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def avatar_url(user, options = { size: 48 })
    if user.avatar_url.present?
      user.avatar_url
    else
      default_url = "#{root_url}guest.png"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      size = options[:size]
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    end
  end

  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar = 
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
