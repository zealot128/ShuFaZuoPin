class Character < ActiveRecord::Base
  has_many :users, :through => :selection
  has_many :selections

  def self.find_for_ajax(term)
    where('pinyin like ? or norm_pinyin like ? or hanzi like ?', *(["#{term}%"] * 3)).limit(15).order(:freq)
  end



  def translation_html
    translation_list.map{|translation|
      translation.gsub( self.hanzi, "<span class='placeholder'>_</span>")
    }.first
  end
  def translation_list
    translation.split("\n").reject{|i| i.empty?}
  end
end
