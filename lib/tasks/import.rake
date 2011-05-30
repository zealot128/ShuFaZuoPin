

namespace "import" do

  desc "xiaoma hsk level 1 import"
  task :xiaoma => :environment do
    load "lib/tasks/xiaoma.rb"
  end

end
