# Preview all emails at http://localhost:3000/rails/mailers/auto_update
class AutoUpdatePreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/auto_update/partner_update
  def partner_update
    AutoUpdate.partner_update
  end

end
