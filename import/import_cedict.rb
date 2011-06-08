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

doc = File.read("#{Rails.root}/import/cedict_1_0_ts_utf-8_mdbg.txt")
lines = doc.split("\n")
lines = lines.reject{|i| i[0] == "#"}

tuples = lines.map{|line|
  line.strip.match(/^(.*) (.*) \[(.*)\] \/(.*)\/$/)[1..5] rescue puts line
}
i=0
tuples.each do |tra,hanzi,pinyin,translation|
  hanzi.strip!
  pinyin.strip!
  pinyin.downcase!
  next if hanzi.length < 2

  word = Word.find_or_initialize_by_hanzi(hanzi)
  next unless word.new_record?
  word.translation = translation.gsub("/","\n")
  word.tone = get_tone pinyin
  word.norm_pinyin = pinyin
  word.pinyin = pinyin.split(" ").map{|char|
    Character.find_by_norm_pinyin(char).norm_pinyin
  }.join(" ")



  if translation.include? "CL:"
    word.zew = translation.match(/CL:([^\[\]]+)/)[1][-1]
  end
  word.save
  puts word.pinyin
  puts word.norm_pinyin
end

