class RefreshAllStats < ActiveJob::Base
  queue_as :default
  # include SuckerPunch::Job

  def perform
    handles = Handle.all
    handles.each do |handle|
      RefreshStats.perform_later(handle)
    end
  end
end