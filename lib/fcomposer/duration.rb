#   fcomposer - duration.rb
#
#   Copyright (c) 2009 Francisco Tufró <contacto@franciscotufro.com.ar>
#
#   See LICENCE in the root directory.

module FComposer

  # The Note class handles the basic structure for music notation.
  # To understand the nomenclature of this code please head to http://en.wikipedia.org/wiki/Note

  class Duration
    attr_accessor :name, :augmented

    @@duration_values = { 
        'whole' => 4.0, 
        'half' => 2.0, 
        'quarter' => 1.0, 
        'eighth' => 0.5,
        'sixteenth' => 0.25,
        'thirtysecond' => 0.125,
        'sixtyfourth' => 0.0625
    }
    
    # Generates a new Note object.
    # You can pass the following parameters within a hash: 
    # * name (The duration name of the note, can be "whole", "half", "quarter", "eighth", "sixteenth", "thirtysecond", "sixtyfourth", default is "quarter")
    # * augmented (Sums half the duration)
    #
    # <tt>note = FComposer::Duration.new(:duration => "whole", :augmented => 1)</tt>
    def initialize(options = {})
      defaults = { :name => "quarter", :augmented => 0 }
      @name = options[:name]  ? options[:name] : defaults[:name]
      @augmented = options[:augmented]  ? options[:augmented] : defaults[:augmented]
    end

   # Returns the next duration type. Does not modify the current note.
    #
    # <tt>note.duration => "quarter"</tt>
    #
    # <tt>note.next_duration => "eighth"</tt>
    def next
      case @name
        when "whole"
          return Duration.new(:name => "half")
        when "half"
          return Duration.new(:name => "quarter")
        when "quarter"
          return Duration.new(:name => "eighth")
        when "eighth"
          return Duration.new(:name => "sixteenth")
        when "sixteenth"
          return Duration.new(:name => "thirtysecond")
        when "thirtysecond"
          return Duration.new(:name => "sixtyfourth")
        else
          return nil
      end
    end

    # Returns the previous duration type. Does not modify the current note.
    #
    # <tt>note.duration => "quarter"</tt>
    #
    # <tt>note.next_duration => "half"</tt>
    def previous
      case @name
        when "half"
          return Duration.new(:name => "whole")
        when "quarter"
          return Duration.new(:name => "half")
        when "eighth"
          return Duration.new(:name => "quarter")
        when "sixteenth"
          return Duration.new(:name => "eighth")
        when "thirtysecond"
          return Duration.new(:name => "sixteenth")
        when "sixtyfourth"
          return Duration.new(:name => "thirtysecond")
        else
          return nil
      end
    end

    # Returns the duration of the note for the bpm passed in seconds. Default is 60 bpm
    def value(bpm = 60.0)
      return (@@duration_values[@name] *  60.0) / bpm
    end
  end
end
