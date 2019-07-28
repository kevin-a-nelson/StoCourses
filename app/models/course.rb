class Course < ApplicationRecord
  def days_acronym
    days.scan(/[A-Z]/)
    days = days.join
    days = days.to_s
    days.gsub(/[\"\[\]]/)
  end
end
