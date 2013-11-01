include Math
class Analytics::Base < ActiveRecord::Base

  #Segement is 5 minutes currently
  def self.average_per_segment(column, s_time = Time.new(2000), e_time = Time.now)
    p s_time
    p e_time
    values = self.select(column).where(created_at: s_time..e_time)
    p values
    amount = values.length
    sum = 0
    values.each do |value|
      sum += value[column]
    end
    avg = sum.to_f/amount
  end

  def self.var_per_segment(column)
    avg = Analytics::Base.average(column)
    values = self.select(column).all
    ar = values.map{|v| (v.idea_thread_creates - avg)**2}
    sum = 0
    ar.each do |x|
      sum += x
    end
    sum/avg
  end

  def self.std_dev_per_segment(column)
    var = Analytics::Base.var_per_segment(column)
    sqrt(var)
  end
end
