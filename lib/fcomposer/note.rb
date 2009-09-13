#   fcomposer - note.rb
#
#   Copyright (c) 2009 Francisco Tufró <contacto@franciscotufro.com.ar>
#
#   See LICENCE in the root directory.
#
#   To understand the nomenclature of this code please head to http://en.wikipedia.org/wiki/Note

module FComposer

  # The Note class handles the basic structure for music notation.
  # To understand the nomenclature of this code please head to http://en.wikipedia.org/wiki/Note

  class Note

    attr_accessor :pitch, :octave
    @@note_list = [ ["C"], ["Cs", "Db"],["D"], ["Ds", "Eb"],["E"], ["F"],["Fs", "Gb"],["G"], ["Gs", "Ab"],["A"], ["As", "Bb"],["B"]]

    # Generates a new Note object.
    # You can pass the following parameters within a hash: 
    # * pitch (Is the pitch class, "A" is the default)
    # * octave (The octave number, default is 4)
    #
    # <tt>note = FComposer::Note.new(:pitch => "D", :octave => 5, :accidental => "s")</tt>

    def initialize(options = {})
      defaults = { :pitch => "A", :octave => 4, :accidental => "" }
      @pitch = options[:pitch] ? options[:pitch] : defaults[:pitch]
      @octave = options[:octave]  ? options[:octave].to_i : defaults[:octave].to_i
    end

    # Returns the full name for the note.
    #
    # <tt>note = FComposer::Note.new(:pitch => "D", :octave => 5, :accidental => "s")</tt>
    #
    # <tt>note.name => "Ds5"</tt>
    def name
      return @pitch + @octave.to_s
    end
    
    # Returns the position of the current note in the chromatic scale.
    def position
      @@note_list.each_index do |index|
        return index if @@note_list[index].include?(@pitch)
      end
    end
    
    # Returns the MIDI Note code for the current pitch.
    def to_midi
      return ((@octave + 1) * 12) + (self.position);
    end
    
    # Returns the frequency of the current note in hz. This uses the diatonic scale fixed in 440hz, you can overload this function to fix it in another frequency or use another scale different than the diatonic one.
    def to_frequency
      return 440.0 * (2 ** ((self.to_midi - 69).to_f/12.0))
    end
  
    # Returns the note that has "halves" halve steps up of distance from the actual note.
    def +(halves)
      position = self.position
      result_position = (position + halves)
      result_octave = (result_position >= 0 && result_position > 12) ? self.octave + 1 : self.octave
      result_octave = self.octave - 1 if (result_position < 0)
      result_pitch = @@note_list[result_position % 12][0]
      return Note.new(:pitch => result_pitch, :octave => result_octave)
    end

    # Returns the note that has "halves" halve steps down of distance from the actual note.
    def -(halves)
      return self + (-halves)
    end
  end
end
