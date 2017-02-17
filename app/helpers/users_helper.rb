module UsersHelper
  def gavatar_for(user, options = {size: 80})
    gavatar_id = Digest::MD5::hexdigest user.email.downcase
    gavatar_url = "https://secure.gravatar.com/avatar/#{gavatar_id}?s=#{options[:size]}"
    image_tag(gavatar_url, alt: user.name, class: "gavatar")
  end
end
