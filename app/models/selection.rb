class Selection < ActiveRecord::Base
  belongs_to :user
  belongs_to :character
  attr_accessor :search
  attr_accessible :character_id

  MAX_LEVEL = 8

  def self.find_next(user_id, exercise_id)
    level = "level_#{exercise_id.to_i}"
    next_visit = "next_visit_#{exercise_id.to_i}"
    q  = Selection.where(:user_id => user_id).order( next_visit).limit(1)

    #any empty?:
    q_empty = q.where("#{next_visit} is null")
    if q_empty.first.present?
      return q_empty.first
    end

    q.first
  end

  def due?(exercise_id)
    column = "next_visit_#{exercise_id}"
    send(column) < DateTime.now rescue true
  end

  def level(exercise)
    send "level_#{exercise[:id]}"
  end

  def next_visit(exercise)
    send "next_visit_#{exercise[:id]}"
  end

  def right(exercise_id)
    column = "level_#{exercise_id}"
    level = send(column)
    if level < MAX_LEVEL
      self.instance_eval "self.#{column}+=1"
    end

    nv_column = "next_visit_#{exercise_id}"
    level = send(column)
    self.instance_eval "self.#{nv_column}= Selection.level_time(#{level})"
  end

  def wrong(exercise_id)
    column = "level_#{exercise_id}"
    if send(column) > 0
      self.instance_eval "self.#{column}-=1"
    end

    nv_column = "next_visit_#{exercise_id}"
    level = send(column)
    self.instance_eval "self.#{nv_column}= Selection.level_time(#{level})"
  end

  def self.level_time(level)
    time = case level
           when 0 then lambda {5.minutes}
           when 1 then lambda {10.minutes }
           when 2 then lambda {60.minutes }
           when 3 then lambda {6.hour }
           when 4 then lambda {1.day}
           when 5 then lambda {7.days}
           when 6 then lambda {25.days}
           when 7 then lambda {2.months}
           when 8 then lambda {7.months}
           else raise "Error"
           end
    time.call.from_now
  end


  def self.count_due(ex_id, user_id)
    next_visit = "next_visit_#{ex_id.to_i}"
    Selection.where(:user_id => user_id).where( "#{next_visit} is null or #{next_visit} < ?", DateTime.now).count
  end
end
