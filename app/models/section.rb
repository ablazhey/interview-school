class Section < ApplicationRecord


    belongs_to :teacher_subject
    belongs_to :class_room

    def full_info
        "#{self.day} #{self.from.to_s(:time)} - #{self.to.to_s(:time)} #{self.teacher_subject.subject_name} in class #{self.class_room.name}"
    end

end
