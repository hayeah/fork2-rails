
json.total_courses @total_courses.to_s
json.intervals @intervals.to_s

json.users @cohort_users do |cu|

  json.name cu.user.name
  json.email cu.user.email

  json.checkins cu.checkins do |checkin|
    json.lesson_id checkin.cohort_lesson_id
    json.time_spent checkin.time_spent
    json.difficulty checkin.difficulty
    json.feedback checkin.feedback
    json.day_index checkin.created_at.to_date.mjd-@start_date.mjd+1

  end

end






