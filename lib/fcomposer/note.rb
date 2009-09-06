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

    attr_accessor :pitch, :octave, :accidental
    @@note_list = [ ["C"], ["Cs", "Db"],["D"], ["Ds", "Eb"],["E"], ["F"],["Fs", "Gb"],["G"], ["Gs", "Ab"],["A"], ["As", "Bb"],["B"]]

    # Generates a new Note object.
    # You can pass the following parameters within a hash: 
    # * pitch (Is the pitch class, "A" is the default)
    # * octave (The octave number, default is 4)
    # * accidental (The accidental for the note, can be "" for normal,2 "b" for flat or "s" for sharp, default is normal)
    #
    # <tt>note = FComposer::Note.new(:pitch => "D", :octave => 5, :accidental => "s")</tt>

    def initialize(options = {})
      defaults = { :pitch => "A", :octave => 4, :accidental => "" }
      @pitch = options[:pitch] ? options[:pitch] : defaults[:pitch]
      @octave = options[:octave]  ? options[:octave].to_i : defaults[:octave].to_i
      @accidental = options[:accidental]  ? options[:accidental] : defaults[:accidental]
    end

    # Returns the full name for the note.
    #
    # <tt>note = FComposer::Note.new(:pitch => "D", :octave => 5, :accidental => "s")</tt>
    #
    # <tt>note.name => "Ds5"</tt>
    def name
      return "#{@pitch}#{@accidental}#{@octave}"
    end
    
    # Returns the position of the current note in the chromatic scale.
    def position
      @@note_list.each_index do |index|
        return index if @@note_list[index].include?("#{@pitch}#{@accidental}")
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

  end
end
