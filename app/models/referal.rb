class Referal < ActiveRecord::Base

  # who refered a user
  belongs_to :user
  # User who was refered
  belongs_to :referred_to, :class_name => User, :foreign_key => :referred_to_id, :validate => true
end
