namespace :analytics do
  task gather_base: :environment do
    if !Analytics::Base.all.empty?
      last = Analytics::Base.order("end_time DESC").first
      s_time = last.end_time
    else
      first = PublicActivity::Activity.order("created_at ASC").first
      time = first.created_at
      s_time = round_time_down(time)


    end

    e_time = Time.now
    e_time = round_time_up(e_time)
    c_time = s_time

    while c_time < e_time
      p c_time
      activities = PublicActivity::Activity.where(created_at: (c_time)..(c_time + 5.minutes))
      it_c = activities.where(key: "idea_thread.create").length
      it_u = activities.where(key: "idea_thread.update").length
      it_d = activities.where(key: "idea_thread.destroy").length

      i_c = activities.where(key: "idea.create").length
      i_u = activities.where(key: "idea.update").length
      i_d = activities.where(key: "idea.destroy").length

      v_c = activities.where(key: "vote.create").length
      v_u = activities.where(key: "vote.update").length
      v_d = activities.where(key: "vote.destroy").length

      c_c = activities.where(key: "comment.create").length
      c_u = activities.where(key: "comment.update").length
      c_d = activities.where(key: "comment.destroy").length

      Analytics::Base.create( start_time: c_time,
                              end_time: c_time + 5.minutes,
                              idea_thread_creates: it_c,
                              idea_thread_updates: it_u,
                              idea_thread_deletes: it_d,
                              idea_creates: i_c,
                              idea_updates: i_u,
                              idea_deletes: i_d,
                              vote_creates: v_c,
                              vote_updates: v_u,
                              vote_deletes: v_d,
                              comment_creates: c_c,
                              comment_updates: c_u,
                              comment_deletes: c_d)

      c_time += 5.minutes

    end
  end

  def round_time_down(time)
      ones_place = time.min % 10
      if ones_place < 5
        new_min = time.min - ones_place
        s_time = Time.utc(time.year, time.month, time.day, time.hour, new_min)
      else
        new_min = time.min - ones_place + 5
        s_time = Time.utc(time.year, time.month, time.day, time.hour, new_min)
      end

      return s_time
  end


  def round_time_up(time)
    ones_place = time.min % 10
    if ones_place < 5
      new_min = time.min - ones_place + 5
      e_time = Time.utc(time.year, time.month, time.day, time.hour, new_min)
    else
      new_min = time.min - ones_place + 10
      p new_min
      if new_min == 60
        p time
        e_time = Time.utc(time.year, time.month, time.day, time.hour + 1.hour)
      else
        e_time = Time.utc(time.year, time.month, time.day, time.hour, new_min)
      end
    end
    return e_time
  end

end
