module ApplicationHelper

	def include_javascript(path)
		s="<script type=\"text/javascript\" src=\"#{path}\"></script>"
		content_for(:head,raw(s))	
	end

	def include_stylesheet(path)
		s="<link rel=\"stylesheet\" href=\"#{path}\" />"
		content_for(:head,raw(s))	
	end
end
