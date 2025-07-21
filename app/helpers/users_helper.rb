module UsersHelper

    # returns the Gravatar for the given user
    def gravatar_for(user, options = { size: 80 })
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}?s=#{size}&d=identicon"
        image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end
end
