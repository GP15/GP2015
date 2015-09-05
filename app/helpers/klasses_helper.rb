module KlassesHelper

  # Output for a klass' reservation limit.
  def is_unlimited?(limit)
    limit == 0 ? "unlimited" : limit
  end

end
