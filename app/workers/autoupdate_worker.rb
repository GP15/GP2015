class AutoupdateWorker
  include Sidekiq::Worker
  def perform
    Schedule.in_one_hour.each do |schedule|
      AutoUpdate.partner_update(schedule).deliver      	
    end 
    AutoupdateWorker.perform_in(5.minutes)
  end
end
