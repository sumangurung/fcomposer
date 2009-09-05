#   fcomposer - scale.rb
#
#   Copyright (c) 2009 Francisco Tufró <contacto@franciscotufro.com.ar>
#
#   This program is free software.
#   You can distribute/modify this program under the terms of
#   the GNU Lesser General Public License version 2.
#
module FComposer
  class Scale
    attr_accessor :name, :pitchs

    def initialize( options = {})
      defaults = { :name => "C Major", :pitchs => ["C","D","E","F","G","A","B"]}
      self.name = options[:name] ? options[:name] : defaults[:name]
      self.pitchs = options[:pitchs] ? options[:pitchs] : defaults[:pitchs]
    end

    # size: returns the number of notes in the scale
    def size
      return pitchs.size
    end

  end
end

