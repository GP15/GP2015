class CreateSiteInfos < ActiveRecord::Migration
  def change
    create_table :site_infos do |t|
      t.string :support_email
      t.string :partner_email
      t.string :facebook
      t.string :twitter
      t.string :instagram

      t.timestamps null: false
    end

    SiteInfo.create(
      support_email: 'support@geniuspass.com',
      partner_email: 'partners@geniuspass.com',
      facebook: 'https://www.facebook.com/GeniusPass-Malaysia-417492548424501',
      twitter: 'https://twitter.com/GeniusPass',
      instagram: 'https://www.instagram.com/geniuspass_malaysia'
    )
  end
end
