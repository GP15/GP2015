module UsersHelper

  def subscription_status_translate(status)
    status ? "Active" : "Inactive"
  end
end
