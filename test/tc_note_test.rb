class FComposer::NoteTest < Test::Unit::TestCase
  def test_note_creation_default_values
    note = FComposer::Note.new
    assert_equal "A", note.pitch
    assert_equal 4, note.octave
    assert_equal "", note.accidental
    assert_equal "A4", note.name
    assert_equal "Quarter", note.duration
    assert_equal 0, note.augmented
  end

  def test_note_creation_special_values
    note = FComposer::Note.new(:pitch => "B", :octave => 5, :accidental => "#", :duration => "Whole", :augmented => 1)
    assert_equal "B", note.pitch
    assert_equal 5, note.octave
    assert_equal "#", note.accidental
    assert_equal "B#5", note.name
    assert_equal "Whole", note.duration
    assert_equal 1, note.augmented
  end

end