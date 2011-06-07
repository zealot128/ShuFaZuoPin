

namespace "import" do

  desc "xiaoma hsk level 1 import"
  task :xiaoma => :environment do
    load "lib/tasks/xiaoma.rb"
  end


  desc "cedict import"
  task :cedict => :environment do
    load "lib/tasks/cedict.rb"
  end
end
