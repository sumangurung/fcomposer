#   fcomposer - tc_bar_test.rb
#
#   Copyright (c) 2009 Francisco Tufró <contacto@franciscotufro.com.ar>
#
#   See LICENCE in the root directory.
class BarTest < Test::Unit::TestCase

  def test_bar_creation_default_values
    bar = FComposer::Bar.new
    assert_equal 4, bar.beats
    assert_equal FComposer::Duration.new.value, bar.duration.value
    assert_equal [], bar.notes
  end
  
  def test_bar_creation_with_options
    bar = FComposer::Bar.new(:beats => 5, :duration => FComposer::Duration.new(:name => "eighth"))
    assert_equal 5, bar.beats
    assert_equal FComposer::Duration.new(:name => "eighth").value, bar.duration.value
    assert_equal [], bar.notes
  end

  def test_valid?
    bar = FComposer::Bar.new
    assert bar.valid?

    bar = FComposer::Bar.new(:beats => 1, :duration => FComposer::Duration.new(:name => "eighth"), 
      :notes => [{ :pitch => FComposer::Note.new, :duration => FComposer::Duration.new }])
    assert !bar.valid?
  end

  def test_add_note
    bar = FComposer::Bar.new(:duration => FComposer::Duration.new(:name => "eighth"))

    # Default duration should be the same as the bar duration
    assert bar.add_note FComposer::Note.new
    assert_equal "eighth", bar.notes[0][:duration].name
    # Test overriding default duration
    assert bar.add_note FComposer::Note.new, :duration => FComposer::Duration.new
    assert bar.add_note(:pitch => FComposer::Note.new)
    assert !bar.add_note(:pitch => FComposer::Note.new)
  end
end
