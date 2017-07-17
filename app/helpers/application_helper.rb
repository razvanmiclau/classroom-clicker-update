module ApplicationHelper
  def display_fullname
    @fullname = current_or_guest_user.first_name + ' ' + current_or_guest_user.last_name
  end

  def display_email
    @email = current_or_guest_user.email
  end

  def display_username
    @username = current_or_guest_user.first_name.downcase + current_or_guest_user.last_name.downcase
  end

  def display_avatar(size)
    gravatar = Digest::MD5::hexdigest(current_or_guest_user.email).downcase
    url = "http://gravatar.com/avatar/#{gravatar}.png?s=#{size}&d=identicon&r=PG"
  end
end
