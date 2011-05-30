require 'test_helper'

class SelectionTest < ActiveSupport::TestCase
  context "for searching next word in queue" do
    setup do
      @user = User.first
      @selection1 = Selection.new(  :character_id => characters(:de))
      @selection1.user = @user
      @selection2 = Selection.new(  :character_id => characters(:yi))
      @selection2.user = @user
    end

    should "return single word from database" do
      assert @selection1.save
      assert_equal @selection1, Selection.find_next( @user.id, 1)
    end

    should "return the word with nil before the same exercise" do
      @selection1.next_visit_1 = 2.days.ago
      @selection1.save
      @selection2.next_visit_1 = nil
      @selection2.save
      assert_equal @selection2, Selection.find_next( @user.id, 1)
    end

    should "return the word with next_visit earlier" do
      @selection1.next_visit_1 = 2.days.ago
      @selection1.save
      @selection2.next_visit_1 = 1.month.ago
      @selection2.save
      assert_equal @selection2, Selection.find_next( @user.id, 1)
    end

    should "crosscheck for previous test" do
      @selection1.next_visit_1 = 2.month.ago
      @selection1.save
      @selection2.next_visit_1 = 1.month.ago
      @selection2.save
      assert_equal @selection1, Selection.find_next( @user.id, 1)
    end

  end

  context "for right wrong actions" do
    setup do
      @user = User.first
      @selection = Selection.new(  :character_id => characters(:de))
      @selection.user = @user
    end

    should "set nil word to 1" do
      assert_difference "@selection.level_1", 1 do
        @selection.right(1)
      end
      assert @selection.next_visit_1 > Time.now
      assert @selection.next_visit_1 < 11.minute.from_now
    end

    should "set maximum of 8 levels" do
      @selection.level_1 = 8
      assert_no_difference "@selection.level_1" do
        @selection.right(1)
      end
      assert @selection.next_visit_1 > 6.months.from_now
      assert @selection.next_visit_1 < 8.months.from_now

    end

    should "wrong" do
      @selection.level_1 = 8
      assert_difference "@selection.level_1", -1 do
        @selection.wrong(1)
      end
    end

    should "more than 0" do
      @selection.level_1 = 0
      assert_no_difference "@selection.level_1" do
        @selection.wrong(1)
      end
      assert @selection.next_visit_1 > 4.minutes.from_now
      assert @selection.next_visit_1 < 8.minutes.from_now
    end

    context "count due" do
      should "single example" do
        @selection.next_visit_1 = 2.days.ago
        @selection.save
        assert_equal 1, Selection.count_due(1, @user.id)
      end
      should "nil example" do
        @selection.next_visit_1 =  nil
        @selection.save
        assert_equal 1, Selection.count_due(1, @user.id)
      end
    end



  end

end
