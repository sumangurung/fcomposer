#   fcomposer examples - guido.rb
#
#   Copyright (c) 2009 Francisco Tufró <contacto@franciscotufro.com.ar>
#
#   This program is free software.
#   You can distribute/modify this program under the terms of
#   the GNU Lesser General Public License version 2.
#
# This example shows how to generate a midi file using fcomposer.
# This requires midilib (you can install it from gems)
#
# The guido's composition method maps vowels with two octaves of C major scale notes:
#   G A B C D   E F G A B   C D E F G   A
#   a e i o u - a e i o u - a e i o u - a
#
# 
#
require 'rubygems'
require 'fcomposer'
require 'midilib/sequence'
require 'midilib/consts'
include MIDI

@vowel_sequence = {
 'a' => ["G3", "E4", "C5", "A5"], 
 'e' => ["A3", "F4", "D5"],
 'i' => ["B3", "G4", "E5"],
 'o' => ["C4", "A4", "F5"],
 'u' => ["D4", "B4", "G5"]
}

def generate_notes_for_text(text)
  text.downcase!
  @notes_for_text = []
  @note = ''
  text.each_char do |character|
    @note = @vowel_sequence[character][rand(@vowel_sequence[character].size)] if /[aeiou]/.match(character)
    @notes_for_text << FComposer::Note.new(:pitch => @note[0..0], :octave => @note[1..1]) if /[aeiou]/.match(character)
  end 
  return @notes_for_text
end

def add_note(note, track, seq)
  track.events << NoteOnEvent.new(0, note.to_midi, 127, 0)
  track.events << NoteOffEvent.new(0, note.to_midi, 127, seq.note_to_delta(note.duration))
end

@text = "Guido's Method set the ground for objective (as non subjective) composition method. I think it's a cool example for this project."
notes = generate_notes_for_text(@text)

seq = Sequence.new()
track = Track.new(seq)
seq.tracks << track
track.events << Tempo.new(Tempo.bpm_to_mpq(120))
track.events << MetaEvent.new(META_SEQ_NAME, 'Guido')
track.name = 'Guido'
track.instrument = GM_PATCH_NAMES[0]
track.events << Controller.new(0, CC_VOLUME, 127)
track.events << ProgramChange.new(0, 1, 0)

notes.each do |note|
  add_note(note,track,seq)
end

# Write the sequence to a MIDI file.
File.open('guidos-method-sample.mid', 'wb') { | file | seq.write(file) }

