class String
  def chinese_chars
    self.each_char.inject("") { |s,c|
      if c.ord >= 0x3400 && c.ord <= 0x9FFF
        s+=c
      end
      s
    }
  end
end
