class RewardsController < ApplicationController

  def index
    @rewards = Reward.all
  end

  def claim
    @reward = Reward.find(params[:id])

    if current_user.blank?
      redirect_to new_user_session_path, notice: 'Sign up to become part of our community!'
    elsif current_user.able_claim_reward?(@reward.point)
      current_user.deduct_reward_points(@reward.point)
      RewardMailer.notify(current_user, @reward).deliver_now
      redirect_to rewards_path, notice: 'Awesome! Keep it up to claim your next reward soon.'
    else
      redirect_to rewards_path, notice: "Unfortunately, you need to do more activities to claim our rewards! Your current point is #{current_user.reward_points}"
    end
  end


end
