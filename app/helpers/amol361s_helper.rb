module Amol361sHelper
  
  require 'set'

	RED_WORDS = %w[cash tt payment credit note deposit returned chq: chq ticket. advertising discount paid damage missing l/c difference bank payable. shortage per support].to_set

	def span_with_possibly_red_color(content)
		classes = if (RED_WORDS & content.split.map(&:downcase)).present?
			{class: "red"}
		else
			{}
		end
		content_tag(:span, content, classes)
	end
	
end
