require "#{Rails.root}/lib/string"
module ExercisesHelper
  def translation_list(character)
    content_tag :ul do
      character.translation_list.map do |transl|
        transl.chinese_chars.each_char.map(&:to_s).uniq.each do |char|
          transl.gsub! char, "<span class='tooltip hanzi-tooltip'>#{char}</span>"
        end

        content_tag :li, transl.html_safe
      end.join.gsub(";","<br/>").html_safe
    end
  end
end
