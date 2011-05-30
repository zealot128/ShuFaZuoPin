require "yaml"
source = open("listnew.tab").read
rows = source.split("\n").map{|i| i.split("\t")}
elements = rows.map{|i|
  a = i[4].split("/").first
  {hanzi: i[1], pinyin: a, trans: i[5], level: (i[0].to_i / 100)}
}
