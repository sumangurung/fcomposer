class FComposer::NoteTest < Test::Unit::TestCase
  def test_note_creation_default_values
    note = FComposer::Note.new
    assert_equal "A", note.pitch
    assert_equal 4, note.octave
    assert_equal "", note.accidental
    assert_equal "A4", note.name
    assert_equal "quarter", note.duration
    assert_equal 0, note.augmented
  end

  def test_note_creation_special_values
    note = FComposer::Note.new(:pitch => "D", :octave => 5, :accidental => "#", :duration => "whole", :augmented => 1)
    assert_equal "D", note.pitch
    assert_equal 5, note.octave
    assert_equal "#", note.accidental
    assert_equal "D#5", note.name
    assert_equal "whole", note.duration
    assert_equal 1, note.augmented
  end
  
  def test_note_position
    note = FComposer::Note.new(:pitch => "D", :accidental => "#")
    assert_equal 3, note.position
    note = FComposer::Note.new(:pitch => "G")
    assert_equal 7, note.position
  end
  
  def test_note_to_midi
    note = FComposer::Note.new(:pitch => "D", :octave => 4)
    assert_equal 62, note.to_midi
  end
  
  # This returns the frequency of the note in the equal-tempered scale fixed in 440.0, you can overload this method to your own scale or fix it in other freq than 440.0
  def test_note_to_frequency
    note = FComposer::Note.new
    assert_equal 440.0, note.to_frequency
    note = FComposer::Note.new(:pitch => "B")
    assert_equal 440.0 * (2 ** ((71 - 69).to_f/12.0)), note.to_frequency
  end
end