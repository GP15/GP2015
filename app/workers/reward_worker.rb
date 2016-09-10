class RewardWorker
  include Sidekiq::Worker

  def perform
    Reservation.expired_hours(1).check_point_earned.each do |reservation|
      reservation.earned_points
    end
    RewardWorker.perform_in(1.hour)
  end

end
