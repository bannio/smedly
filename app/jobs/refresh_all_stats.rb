class RefreshAllStats < ActiveJob::Base
  queue_as :default

  def perform(handles)
    return if handles.empty?
    handles.each do |handle|
      RefreshStats.perform_later(handle)
    end
  end
end