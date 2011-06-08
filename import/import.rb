user = User.first

stuff = YAML.load File.read "export.yml"
stuff.each do |word|
  char = Character.find_by_hanzi(word[:hanzi].strip)
  if char.nil?
    puts "could not find #{word[:hanzi]}"
    next
  end
  selection = Selection.new
  selection.character = char
  selection.user = user
  selection.level_1 = word[:level_1]
  selection.level_2 = word[:level_2]
  selection.save

end

