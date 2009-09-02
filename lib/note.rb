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
    @@note_list = [ ["C"], ["C#", "Db"],["D"], ["D#", "Eb"],["E"], ["F"],["F#", "Gb"],["G"], ["G#", "Ab"],["A"], ["A#", "Bb"],"B"]
    @@duration_list = { "Longa" => 4.0, "Breve" => 2.0, "Whole" => 1.0, "Half" => 0.5, "Quarter" => 0.25, "Eighth" => 0.125, "Sixteenth" => 0.0625, "Thirty-second" => 0.03125, "Sixty-fourth" => 0.015625, "Hundred Twenty-eighth" => 0.0078125 }

    def initialize(options = {})
      defaults = { :pitch => "A", :octave => 4, :accidental => "", :duration_name => "Quarter", :augmented => 0 }
      @pitch = options[:pitch] ? options[:pitch] : defaults[:pitch]
      @octave = options[:octave]  ? options[:octave] : defaults[:octave]
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
  end
end