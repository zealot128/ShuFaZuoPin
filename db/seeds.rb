# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Character.delete_all
items = YAML.load open("db/hanzi.yml")
items.each do |item|
  char = Character.find_or_initialize_by_hanzi item[:char]
  next unless char.new_record?
  char.pinyin = item[:pinyin]
  char.norm_pinyin = item[:normified_pinyin]
  char.translation = item[:info].join("\n")
  char.tone = item[:tone]
  char.freq = item[:level]
  char.save
end

