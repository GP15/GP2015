class Reward < ActiveRecord::Base

  mount_uploader :image, RewardUploader

end
