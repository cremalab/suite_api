include Math
class Analytics::Base < ActiveRecord::Base

  #Segement is 5 minutes currently
  def self.average_per_segment( column,
                                s_time = Time.new(2000),
                                e_time = Time.now)
    values = self.select(column).where(start_time: s_time..e_time)
    amount = values.length
    sum = 0
    values.each do |value|
      sum += value[column]
    end
    avg = sum.to_f/amount
  end

  def self.var_per_segment(column, s_time = Time.new(2000), e_time = Time.now)
    avg = Analytics::Base.average_per_segment(column, s_time, e_time)
    values = self.select(column).where(start_time: s_time..e_time)
    ar = values.map{|v| (v.idea_thread_creates - avg)**2}
    sum = 0
    ar.each do |x|
      sum += x
    end

    sum/avg
  end

  def self.std_dev_per_segment( column,
                                s_time = Time.new(2000),
                                e_time = Time.now)
    var = Analytics::Base.var_per_segment(column, s_time, e_time)
    sqrt(var)
  end
end
