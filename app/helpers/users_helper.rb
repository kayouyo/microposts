module UsersHelper
  def gravatar_for(user, options = { size: 50 })
    # gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    # size = options[:size]
    gravatar_url = "http://www.adiumxtras.com/images/thumbs/miffy_nijntje_3185933778_1_17812_6000_thumb.png"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end