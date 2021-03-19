class TimeValidator < ActiveModel::Validator

  LONG_TIMES = [50, 80]
  TIME_TO_START = Time.parse("7:30AM").to_s(:time)
  TIME_TO_FINISH = Time.parse("10:00PM").to_s(:time)

  def validate(record)
    time_range = options[:fields].map{|field| record.send(field)}

    add_errors(record, options[:fields], "From should be before To") unless range?(time_range)
    add_errors(record, options[:fields], "Section should spend #{LONG_TIMES.join(" or ")}") unless long?(time_range)
    add_errors(record, [:from], "Should start after #{TIME_TO_START}") unless start?(time_range[0])
    add_errors(record, [:from], "Should finish before #{TIME_TO_FINISH}") unless finish?(time_range[1])
    add_errors(record, options[:fields], "Have another lessons in this class room") unless uniq_class_room?(record, time_range)
    add_errors(record, options[:fields], "Have another lessons in this teacher subject") unless uniq_teacher_subject?(record, time_range)


  end

private

  def range?(time_range)
    time_range[1] - time_range[0] > 0
  end

  def start?(from)
    from.to_s(:time) >= TIME_TO_START
  end

  def finish?(to)
    to.to_s(:time) <= TIME_TO_FINISH
  end

  def long?(time_range)
     LONG_TIMES.include?((time_range[1] - time_range[0])/60)
  end

  def uniq_class_room?(record, time_range)
    uniq_day_lass_room = {day: record.day, class_room_id: record.class_room_id}
    !Section.where(uniq_day_lass_room.merge(from: time_range[0]...time_range[1])).or(Section.where( uniq_day_lass_room.merge(to: time_range[0]..time_range[1]))).exists?
  end

   def uniq_teacher_subject?(record, time_range)
    uniq_day_lass_room = {day: record.day, teacher_subject_id: record.teacher_subject_id}
    !Section.where(uniq_day_lass_room.merge(from: time_range[0]...time_range[1])).or(Section.where( uniq_day_lass_room.merge(to: time_range[0]..time_range[1]))).exists?
  end


  def add_errors(record, fields, message)
    fields.each{|field| record.errors.add(field, message) }
  end


end

class Section < ApplicationRecord

    belongs_to :teacher_subject
    belongs_to :class_room


    validates :day, presence: true, :inclusion=> { :in => Date::DAYNAMES }

    validates_with TimeValidator, :fields => [:from, :to]


    def full_info
        "#{self.day} #{self.from.to_s(:time)} - #{self.to.to_s(:time)} #{self.teacher_subject.subject_name} in class #{self.class_room.name}"
    end



end

