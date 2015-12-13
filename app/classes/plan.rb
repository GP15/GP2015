class Plan
  def initialize
    @plans = Braintree::Plan.all
  end

  def get_plan(name)
    @plans.select{|p| p.name.eql?(name)}.first
  end

  def get_registration_plans(names)
    @plans.select{|p| names.include?(p.name)}
  end
end
