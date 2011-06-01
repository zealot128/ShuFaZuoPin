module SelectionsHelper
  def next_visit_words(selection, exercise_id)
    next_visit = selection.send("next_visit_#{exercise_id}")
    if next_visit.present?
      time_part = distance_of_time_in_words_to_now(next_visit)
      sign_part = next_visit > DateTime.now ? "in " : "vor "
      sign_part + time_part
    else
      "Niemals"
    end
  end

  def tonize(pinyin)
    content = ""
    pinyin.split(/([\d ])/).in_groups_of(2).each do |word,tone|
      if (1..4).include? tone.to_i
        klass = "tone-#{tone}"
      else
        klass = ""
      end
      content+= content_tag :span, word, :class => klass
    end
    content.html_safe
  end

end
