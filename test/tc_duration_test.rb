#   fcomposer - tc_duration_test.rb
#
#   Copyright (c) 2009 Francisco Tufró <contacto@franciscotufro.com.ar>
#
#   See LICENCE in the root directory.

class NoteTest < Test::Unit::TestCase

  def test_duration_creation_default_values
    duration = FComposer::Duration.new
    assert_equal "quarter", duration.name
    assert_equal 0, duration.augmented
  end

  def test_duration_creation_special_values
    duration = FComposer::Duration.new(:name => "whole", :augmented => 1)
    assert_equal "whole", duration.name
    assert_equal 1, duration.augmented
  end

  def test_value
    duration = FComposer::Duration.new(:name => "quarter")
    assert_equal 1, duration.value
    assert_equal 0.5, duration.value(120)
    duration = FComposer::Duration.new(:name => "eighth")
    assert_equal 0.5, duration.value
  end

  def test_next
    duration = FComposer::Duration.new(:name => "whole")
    assert_equal "whole", duration.name
    duration = duration.next
    assert_equal "half", duration.name
    duration = duration.next
    assert_equal "quarter", duration.name
    duration = duration.next
    assert_equal "eighth", duration.name
    duration = duration.next
    assert_equal "sixteenth", duration.name
    duration = duration.next
    assert_equal "thirtysecond", duration.name
    duration = duration.next
    assert_equal "sixtyfourth", duration.name
    duration = duration.next
    assert_equal nil, duration
  end

  def test_previous_duration
    duration = FComposer::Duration.new(:name => "sixtyfourth")
    assert_equal "sixtyfourth", duration.name
    duration = duration.previous  
    assert_equal "thirtysecond", duration.name
    duration = duration.previous  
    assert_equal "sixteenth", duration.name
    duration = duration.previous  
    assert_equal "eighth", duration.name
    duration = duration.previous  
    assert_equal "quarter", duration.name
    duration = duration.previous  
    assert_equal "half", duration.name
    duration = duration.previous  
    assert_equal "whole", duration.name
    duration = duration.previous  
    assert_equal nil, duration
  end

end
