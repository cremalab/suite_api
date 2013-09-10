require 'sse'

class EventsController < ApplicationController
  include ActionController::Live
  def index
    sse = SSE.new(response)
    conn = ActiveRecord::Base.connection.raw_connection
    conn.exec("LISTEN \"channel\";")
    begin
      loop do
        conn.wait_for_notify do |event, pid, payload|
          logger.info event
          logger.info pid
          logger.info payload
          sse.write(payload)
        end
      end
    rescue IOError
      # When the client disconnects, we'll get an IOError on write
    ensure
      sse.close
    end

  end
end
