class Listener
  def initialize
    ActiveRecord::Base.connection_pool.with_connection do |connection|
      conn = connection.instance_variable_get(:@connection)
      begin
        conn.async_exec "LISTEN channel1"
        conn.async_exec "LISTEN channel2"

        conn.wait_for_notify do |channel, pid, payload|
          puts "Received a NOTIFY on channel #{channel}"
          puts "from PG backend #{pid}"
          puts "saying #{payload}"
        end
        conn.wait_for_notify(0.5) do |channel, pid, payload|
          puts "Received a second NOTIFY on channel #{channel}"
          puts "from PG backend #{pid}"
          puts "saying #{payload}"
        end
      ensure
        conn.async_exec "UNLISTEN *"
      end
    end
  end

end