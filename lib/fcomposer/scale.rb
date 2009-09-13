#   fcomposer - scale.rb
#
#   Copyright (c) 2009 Francisco Tufró <contacto@franciscotufro.com.ar>
#
#   See LICENCE in the root directory.
#

module FComposer
  class Scale
    attr_accessor :name, :pitches
  
    # @@scale_intervals holds all the scales that are available. You can add your own scales following the examples here.
    @@scale_intervals ={
      "Major" => [2,2,1,2,2,2],
      "Natural Minor" => [2,1,2,2,1,2],
      "Harmonic Minor" => [2,1,2,2,1,3],
      "Hungarian Minor" => [2,1,3,1,1,3],
      "Gypsy Minor" => [2,1,3,1,1,2],
    }

    # Generates a new Scale object.
    # You can pass the following parameters within a hash: 
    # * name (The name of the scale, default "C Major")
    # * pitches (The available pitches in the scale as an array, default ["C","D","E","F","G","A","B"])
    # <tt>scale = FComposer::Scale.new(:name => "Hungarian Minor in A", :pitches => ["A", "B", "C", "Ds", "E", "F" "Gs"])</tt>

    def initialize( options = {})
      defaults = { :name => "C Major", :pitches => ["C","D","E","F","G","A","B"]}
      self.name = options[:name] ? options[:name] : defaults[:name]
      self.pitches = options[:pitches] ? options[:pitches] : defaults[:pitches]
      self.set_scale_from_name(options[:name]) if options[:name] && !options[:pitches]
    end

    # Adds a scale to the list
    def self.add_scale(options)
        @@scale_intervals[options[:name]] = options[:intervals]
    end
    # Returns the number of notes in the scale
    def size
      return self.pitches.size
    end

    # Generates the scale using the built in scale scale that matches with the name.
    # The name should be in the form of "Tonic Scale_Name", example "C Major", "B Natural Minor"
    # Available scales are: "Major", "Natural Minor", "Harmonic Minor", "Hungarian Minor" and "Gipsy Minor"
    def set_scale_from_name(name)
      self.name = ""
      self.pitches = []

      @@scale_intervals.each_key do |scale_name|
        if name.match(/#{scale_name}/)
          note = name.gsub(scale_name, "").chop
          scale_result = [ note ]
          @@scale_intervals[scale_name].each do |interval|
            scale_result << (Note.new(:pitch => scale_result.last) + interval).pitch
          end
          self.name = name
          self.pitches = scale_result
        end
      end
    end
  end
end

