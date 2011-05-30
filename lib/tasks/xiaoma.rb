require "open-uri"
require "iconv"
require "unicode_utils"
def get_tone(pinyin)
  stuff = pinyin.gsub(/[a-zA-Z]/, "")
  if stuff.empty?
    return 0
  end

  tone = case UnicodeUtils.char_name stuff
         when /GRAVE/ then 4
         when /ACUTE/ then 2
         when /MACRON/ then 1
         when /CARON/ then 3
         else 0
         end
end

if false
  doc = Hpricot open("http://www.xiaoma.info/freq.php?hsk=1&order=freq")
  elements = doc.search("p.hz a")
  elements.each do |element|
    hanzi = element.inner_text
    char = Character.find_by_hanzi(hanzi)
    if char.nil?
      puts "#{hanzi} not found!"
    else
      char.hsk_level = 1
      char.save
    end
  end
end

if false
  (1..4).each do |hsk_level|
    doc = Hpricot open("http://www.xiaoma.info/compound.php?hsk=#{hsk_level}&order=one")

    news = []
    elements = doc.search(".cidian tr").map{|i| i.search("td").map{|i| i.inner_text}}
    elements.each do |element|
      char = Character.find_or_initialize_by_hanzi(element[0])
      char.hsk_level = hsk_level
      if char.new_record?
        char.pinyin = element[1]
        char.tone = get_tone element[1]
        char.norm_pinyin = Iconv.conv "US-ASCII//TRANSLIT", "UTF-8", element[1]
        char.norm_pinyin += char.tone.to_s
        char.translation = element[2]
        news << char
      else

      end
      char.save
    end
    puts "in level #{hsk_level}"
    pp news
  end
end

puts "radicals"

doc = Hpricot open( "http://www.xiaoma.info/bushou.php?ext=1")
elements = doc.search(".radicals tr")
elements.shift
news = []
elements.map{|i| i.search("td").map{|i| i.inner_text}}.each do |nr,hanzi,strokes,pinyin,trans|
  hanzi = hanzi[0]
  char = Character.find_or_initialize_by_hanzi(hanzi)
  if char.new_record?
    char.pinyin = pinyin
    alternate = hanzi[1..-1].strip

    char.tone = get_tone pinyin
    char.norm_pinyin = Iconv.conv "US-ASCII//TRANSLIT", "UTF-8", pinyin
    char.norm_pinyin += char.tone.to_s
    char.translation = "Radical #{nr}/#{strokes} strokes, #{trans}"
    if alternate.present?
      char.translation = alternate + " " + char.translation
    end
    news << char
  else

  end
  char.save
end
pp news


