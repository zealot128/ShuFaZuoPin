

namespace "import" do

  desc "xiaoma hsk level 1 import"
  task :xiaoma => :environment do
    load "lib/tasks/xiaoma.rb"
  end


  desc "cedict import"
  task :cedict => :environment do
    load "lib/tasks/cedict.rb"
  end

  desc "import etymology for existing characters/words"
  task :ciyuan => :environment do
    Character.where("CHAR_LENGTH(hanzi) = 1 and phonetic is null").each do |char|
      result = Ciyuan.search(char.hanzi)
      char.etymology = result.etymology
      char.phonetic = result.phonetic
      puts char.save
    end
  end
end
