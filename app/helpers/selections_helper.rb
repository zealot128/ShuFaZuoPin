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

  def general_tonize(hanzi,pinyin)
    couples = hanzi.each_char.map.zip pinyin.split(" ")
    couples.map do |char,pinyin|
      tonize_character(char, pinyin)
    end.join("").html_safe
  end

  def tonize_character(char,pinyin)
    char_db = Character.find_by_hanzi(char)
    tone = pinyin.match(/(\d)/)[1].to_i rescue ""

    if (1..4).include? tone
      klass = "tone-#{tone}"
    else
      klass = ""
    end
    link = link_to char, char_db, :rel => :facebox
    content_tag :span, link, :class => klass
  end

  def progress_bar(exercise_id, user)
    total = Selection.where(:user_id => user).count
    done = total - Selection.count_due(exercise_id, user.id)
    percent = done * 100 / total

    content_tag :div, :class => :progress_bar do
      html = content_tag :strong, ( "#{done} / #{total}" )
      html +=content_tag :span, :style => "width: #{percent}%;" do
        "&nbsp;".html_safe
      end
      html
    end
  end

end
