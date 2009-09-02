#   fcomposer - note.rb
#
#   Copyright (c) 2009 Francisco Tufró <contacto@franciscotufro.com.ar>
#
#   This program is free software.
#   You can distribute/modify this program under the terms of
#   the GNU Lesser General Public License version 2.
#
#
#   To understand the nomenclature of this code please head to http://en.wikipedia.org/wiki/Note

module FComposer
  class Note
    attr_accessor :pitch, :octave, :accidental, :duration_name, :duration_value, :augmented
    @@note_list = [ ["C"], ["C#", "Db"],["D"], ["D#", "Eb"],["E"], ["F"],["F#", "Gb"],["G"], ["G#", "Ab"],["A"], ["A#", "Bb"],["B"]]
    @@duration_list = { 'whole' => 4.0, 'half' => 2.0, 'quarter' => 1.0, 'eighth' => 0.5, '8th' => 0.5, 'sixteenth' => 0.25, '16th' => 0.25, 'thirty second' => 0.125, 'thirtysecond' => 0.125, '32nd' => 0.125, 'sixty fourth' => 0.0625, 'sixtyfourth' => 0.0625, '64th' => 0.0625 }
    def initialize(options = {})
      defaults = { :pitch => "A", :octave => 4, :accidental => "", :duration_name => "quarter", :augmented => 0 }
      @pitch = options[:pitch] ? options[:pitch] : defaults[:pitch]
      @octave = options[:octave]  ? options[:octave].to_i : defaults[:octave].to_i
      @accidental = options[:accidental]  ? options[:accidental] : defaults[:accidental]
      self.duration = options[:duration]  ? options[:duration] : defaults[:duration_name]
      @augmented = options[:augmented]  ? options[:augmented] : defaults[:augmented]
    end
    
    def name
      return "#{@pitch}#{@accidental}#{@octave}"
    end
    
    # This function lookups the time fraction for the selected duration
    def duration=(duration_name)
      @duration_name = duration_name
      @duration_value = @@duration_list[duration_name]
    end
    
    def duration
      return @duration_name
    end
    
    def position
      @position = 0
      @@note_list.each do |note|
        return @position if note.include?("#{@pitch}#{@accidental}")
        @position += 1
      end
    end
    
    def to_midi
      return ((@octave + 1) * 12) + (self.position);
    end
    
    def to_frequency
      return 440.0 * (2 ** ((self.to_midi - 69).to_f/12.0))
    end
  end
end