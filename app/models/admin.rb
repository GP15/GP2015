class Admin < ActiveRecord::Base

  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :lockable
end
