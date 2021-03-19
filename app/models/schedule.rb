class OverlapValidator < ActiveModel::Validator

    def validate(record)
        add_errors(record, options[:fields], "Have another lessons in this time") unless range?(record)
    end


private
    def range?(record)
        !Schedule.includes(:section).where(sections: {day: record.section.day, from: record.section.from...record.section.to})
            .or(Schedule.includes(:section).where(sections: {day: record.section.day, to: record.section.from...record.section.to}))
    end

    def add_errors(record, fields, message)
        fields.each{|field| record.errors.add(field, message) }
    end

end


class Schedule < ApplicationRecord

    belongs_to :student
    belongs_to :section

    validates :student, uniqueness: { scope: :section }

    validates_with OverlapValidator, :fields => [:section]



end
