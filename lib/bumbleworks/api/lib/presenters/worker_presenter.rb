module Bumbleworks
  module Api
    class WorkerPresenter < Presenter
      def to_hash
        {
          :id => presented.id,
          :pid => presented.pid,
          :name => presented.name,
          :state => presented.state,
          :ip => presented.ip,
          :hostname => presented.hostname,
          :system => presented.system,
          :launched_at => presented.launched_at,
          :updated_at => presented.updated_at,
          :worker_class => presented.worker_class_name,
          :uptime => presented.uptime,
          :processed_last_minute => presented.processed_last_minute,
          :wait_time_last_minute => presented.wait_time_last_minute,
          :processed_last_hour => presented.processed_last_hour,
          :wait_time_last_hour => presented.wait_time_last_hour
        }
      end
    end
  end
end