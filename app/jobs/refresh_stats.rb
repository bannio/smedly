class RefreshStats < ActiveJob::Base
  queue_as :default

  def perform(handle)
    ActiveRecord::Base.connection_pool.with_connection do
      success = handle.refresh_twitter_stats
      handle.save! if success
    end
  end
end