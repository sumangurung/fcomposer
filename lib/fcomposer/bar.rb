#   fcomposer - bar.rb
#
#   Copyright (c) 2009 Francisco Tufró <contacto@franciscotufro.com.ar>
#
#   See LICENCE in the root directory.
#
#   To understand the nomenclature of this code please head to http://en.wikipedia.org/wiki/Bar_%28music%29

module FComposer
  class Bar
    attr_accessor :beats, :duration, :notes
    #@@errors = [ "The note exceeds the bar size" ]
    
    # Generates a new Bar object.
    # You can pass the following parameters within a hash: 
    # * beats (The number of beats for the bar, 4 is the default)
    # * duration (The duration of each bar's beat, "quarter" is the default)
    # * notes (The note list for this bar, the default is an empty list)
    #
    # <tt>bar = FComposer::Bar.new(:beats => 1, :beat_duration => Duration.new, :notes => [ FComposer::Note.new ])</tt>
    def initialize(options = {})
      defaults = { :beats => 4, :duration => Duration.new, :notes => []}
      @beats = options[:beats]  ? options[:beats] : defaults[:beats] 
      @duration = options[:duration]  ? options[:duration] : defaults[:duration]
      @notes = options[:notes]  ? options[:notes] : defaults[:notes]
    end
    
    # Returns true if the note list fits in the bar size
    def valid?
      return filled <= size
    end
  
    # Adds a note to the note list unless the note exceeds the available space in the bar.
    # Returns true if 
    def add_note (note,options = {})
      duration = options[:duration] ? options[:duration] : @duration
      fits = (filled + duration.value) <= size
      @notes << {:note => note, :duration => duration } if fits
      return fits
    end

    # Sums the durations of all the notes in the bat and returns it
    def filled
      sum = 0
      @notes.each { |note| sum += note[:duration].value }
      return sum
    end

    # Returns the measure duration in terms of quarter notes
    def size
      return @beats *  @duration.value
    end

  end
end

