require "hpricot"
require "ya2yaml"

require "iconv"
require "unicode_utils"
require "open-uri"
source = open("http://www.zein.se/patrick/3000char.html").read
source = Iconv.conv "UTF-8//IGNORE", "GB2312", source

doc = Hpricot source

trs = doc.search("blockquote table tr")
trs.shift


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



rows = trs.map{|i| i.search("td").map{|i| i.inner_text}}
result = rows.map { |a,b,c|
  pinyin = c.match(/\[([^\]]+)\]/)[1]
  translations = c.gsub("?","").split("\n")
  char = b[0]
  level = a.to_i / 100
  tone = get_tone(pinyin)
  normified_pinyin = Iconv.conv "US-ASCII//TRANSLIT", "UTF-8", pinyin
  if tone > 0
    normified_pinyin += tone.to_s
  end


  {
    :pinyin => pinyin, :char => char, :info => translations, :level => level,
    :tone => tone,
    :normified_pinyin => normified_pinyin
  }
}
puts result.ya2yaml(:syck_compatible => true)


