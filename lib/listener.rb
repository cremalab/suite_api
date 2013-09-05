class Listener
  def initialize
    ActiveRecord::Base.connection_pool.with_connection do |connection|
      conn = connection.instance_variable_get(:@connection)
      p conn
      p "Here"
      begin
        p "Inside"

#         stmt = conn.create_statement
#         stmt.execute("LISTEN ideas_ch")
#         stmt.close
        conn.async_exec "LISTEN ideas_ch"

        p Idea.create({title: "Meatloaf at YJ's",
                      idea_thread_id: 2,
                      when: "2013-08-28 09:26:06 -0500",
                      description: "Mmmmm... eatloaf", user_id: 1})
        Idea.create({title: "Meatloaf at YJ's",
                      idea_thread_id: 2,
                      when: "2013-08-28 09:26:06 -0500",
                      description: "Mmmmm... eatloaf", user_id: 1})

        notifications = conn.get_notifications

        notifications.each do |notification|
          unless notification.nil?
            puts "NOTIFICATION ------------"
            puts "pid: #{notification.pid}"
            puts "name: #{notification.name}"
            puts "param: #{notification.parameter}"
            puts "-------------------------"
          end
        end

        # conn.wait_for_notify do |channel, pid, payload|
        #   puts "Received a NOTIFY on channel #{channel}"
        #   puts "from PG backend #{pid}"
        #   puts "saying #{payload}"
        # end

        # conn.wait_for_notify(0.5) do |channel, pid, payload|
        #   puts "Received a second NOTIFY on channel #{channel}"
        #   puts "from PG backend #{pid}"
        #   puts "saying #{payload}"
        # end
      ensure
        p "Ensure"
        conn.async_exec "UNLISTEN *"
      end
    end
  end

end