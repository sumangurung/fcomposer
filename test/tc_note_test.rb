#   fcomposer - tc_note_test.rb
#
#   Copyright (c) 2009 Francisco Tufró <contacto@franciscotufro.com.ar>
#
#   See LICENCE in the root directory.
#   To understand the nomenclature of this code please head to http://en.wikipedia.org/wiki/Note

class NoteTest < Test::Unit::TestCase
  def test_note_creation_default_values
    note = FComposer::Note.new
    assert_equal "A", note.pitch
    assert_equal 4, note.octave
    assert_equal "A4", note.name
  end

  def test_note_creation_special_values
    note = FComposer::Note.new(:pitch => "Ds", :octave => 5)
    assert_equal "Ds", note.pitch
    assert_equal 5, note.octave
    assert_equal "Ds5", note.name
  end
  
  def test_note_position
    note = FComposer::Note.new(:pitch => "Ds")
    assert_equal 3, note.position
    note = FComposer::Note.new(:pitch => "G")
    assert_equal 7, note.position
  end
  
  def test_note_to_midi
    note = FComposer::Note.new(:pitch => "D", :octave => 4)
    assert_equal 62, note.to_midi
  end

  def test_note_to_frequency
    note = FComposer::Note.new
    assert_equal 440.0, note.to_frequency
    note = FComposer::Note.new(:pitch => "B")
    assert_equal 440.0 * (2 ** ((71 - 69).to_f/12.0)), note.to_frequency
  end
  
  def test_plus
    note = FComposer::Note.new(:pitch => "D")
    assert_equal "D", note.pitch
    # A whole    
    note2 = note + 2
    assert_equal "E", note2.pitch
    assert_equal note.octave, note2.octave

    # An octave up
    note2 = note + 12
    assert_equal note.pitch, note2.pitch
    assert_equal note.octave + 1, note2.octave

    # An octave, a tone and a half down
    note2 = note - 16
    assert_equal "As", note2.pitch
    assert_equal note.octave - 1, note2.octave
  end
end
