class AddRewardSectionToSiteInfos < ActiveRecord::Migration
  def change
    add_column :site_infos, :reward_section, :boolean
  end
end
