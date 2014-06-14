# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$.ajax("/admin/status/user_data.json").done (data) ->

	t=$('#user-template li')
	for user in data.users

		$template=t.clone()
		$('.user-name',$template).text user.name
		$('.user-email',$template).text user.email
		percentage= ( (user.checkins.length+0.0)/data.total_courses*100 ).toFixed(2)+"%"
		$('.percentage',$template).text percentage


		generateDay=(checkins) ->
			if checkins
				if checkins.length==1
					"<div class='day difficulty-#{checkins[0].difficulty}'>#{checkins[0].lesson_id}</div>"
				else
					result="<div class='day multi-checked'><p class='multi-lessons'>"
					for checkin in checkins
						result+="<span class='difficulty-#{checkin.difficulty}'>#{checkin.lesson_id}</span><br>"

					result+="</p></div>"
			else
				"<div class='day difficulty-undone'></div>"

		# return checkins belong to someday , key: day index value: corresponding checkins
		checkinDays={}

		for c in user.checkins
			checkinDays[c.day_index] ?=[]
			checkinDays[c.day_index].push c



		days=""
		for index in [1..data.intervals]
			days+=generateDay checkinDays[index]
			days+="<div class='blank'></div>" if index%7==0

		$('.user-timeline',$template).append($(days));


		$template.appendTo '#users-container'



