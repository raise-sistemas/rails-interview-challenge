module Cachable
  extend ActiveSupport::Concern

  included do
    after_commit :reload_available_events_cache
  end

  private
  #
  def reload_available_events_cache
    Rails.cache.delete("available_events")
  end
end
