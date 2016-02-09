namespace :notification do
  task :auto_update => :environment do
    Schedule.in_one_hour.each do |schedule|
      AutoUpdate.partner_update(schedule).deliver      	
    end 
  end
end
