module UsersHelper

    # returns the Gravatar for the given user
    def gravatar_for(user)
        gravatar_url = "https://secure.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}?s=80&d=identicon"
        image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end
end
