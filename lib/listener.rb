class Listener
  def initialize
    @conn = ActiveRecord::Base.connection.raw_connection

    #result = conn.exec("LISTEN \"ideas_ch\";")
    #p result.count

    @conn.exec("LISTEN \"ideas_ch\";")
    @conn.exec("NOTIFY \"ideas_ch\";")
  end

  def listen
    loop do
      @conn.wait_for_notify do |event, pid|
        p event
        p pid
        yield
      end
    end
  end

  def close
    @conn.exec("UNLISTEN *;")
  end

end