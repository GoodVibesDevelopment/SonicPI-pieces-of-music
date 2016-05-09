use_bpm 220

##################### variables #####################
samples = "D:/Users/Mamal/Desktop/SAMPLE/"

kick1 = "513TubeDrumHitsB866_Wav_SP/513TubeDrumHits_Wav_SP/Samples/Kicks/1_A#4_Kick_SP.wav"
snare1 = "513TubeDrumHitsB866_Wav_SP/513TubeDrumHits_Wav_SP/Samples/Snares/1_C#3_Snare_SP.wav"
hat1 = "513TubeDrumHitsB866_Wav_SP/513TubeDrumHits_Wav_SP/Samples/Hats & Shakers/2_G1_Hat_SP.wav"
perc1 = "513TubeDrumHitsB866_Wav_SP/513TubeDrumHits_Wav_SP/Samples/Percussion/1_A#3_Perc_SP.wav"
cym1 = "513TubeDrumHitsB866_Wav_SP/513TubeDrumHits_Wav_SP/Samples/Rides & Cymbals/1_B1_Cymbal_SP.wav"
tom1 = "513TubeDrumHitsB866_Wav_SP/513TubeDrumHits_Wav_SP/Samples/Toms/1_G5_Tom_SP.wav"

sax = "moje/sax.wav"
sax2 = "moje/sax23.wav"

#################### functions #####################

define :play_track do |name, pattern, repeats|
  repeats.times do
    pattern.each do |smpl|
      sample samples+name, amp: smpl * 4
      sleep 0.5
    end
  end
end

#################### patterns #####################


kick_pat1 = [4, 0, 0, 3, 0, 0, 0, 0]
kick_pat2 = [3, 0, 0, 3, 0, 0, 1, 2]

hat_pat1 = [0.6, 0.6, 1.2, 0]

snare_pat1 = [0, 0, 0.7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

perc_pat1 = [0, 0, 2, 0, 0, 2, 0, 0, 2, 0, 2, 0, 0, 2, 0, 0]

cym_pat1 = [2, 0, 0, 0]

tom_fill = [2, 0, 0, 2, 0, 0, 2, 3, 0, 0, 0, 2, 2, 2, 2, 2]

sax_pat = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
silence = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]


#################### music #####################

live_loop :kick do
  play_track kick1, kick_pat1, 3
  play_track kick1, kick_pat2, 1
end

live_loop :hat, sync: :kick do
  #play_track hat1, hat_pat1, 1
end

live_loop :snare, sync: :kick do
  #play_track snare1, snare_pat1, 1
end

live_loop :perc, sync: :kick do
  play_track perc1, perc_pat1, 1
end

live_loop :sax, sync: :kick do
  #start = range(0, 0.5)
  with_fx :reverb do
    sax_rhythm = (ring 1, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0)
    sax_notes = (stretch [0, 4, -1], 16)
    sample samples+sax, start: 0.4, finish: 0.45, amp: sax_rhythm.tick * 8, pan: rand, pitch: sax_notes.tick
    sleep 1
  end
end



live_loop :cym, sync: :kick do
  #sleep 30
  #play_track cym1, cym_pat1, 1
end

live_loop :tom, sync: :kick do
  #play_track tom1, [0, 0, 0, 0], 12
  #play_track tom1, tom_fill, 1
end

bassline_rhythm = (ring 1, 0, 0, 0, 1, 0, 0, 0,
                   1, 0, 0.5, 0, 1, 0, 0.5, 0)
bassline_notes = (stretch [:e1] * 12 + [:c2, :c2, :d1, :d1], 8)
live_loop :bass, auto_cue: false do
  with_synth :fm do
    play bassline_notes.look,
      amp: bassline_rhythm.tick * 3,
      attack: 0.03, divisor: 1, depth: 2.5
  end
  sleep 0.25
end

live_loop :synth, sync: :kick do
  #play (ring :g3, :b3, :d4, :fs4).tick, amp: 0.6 * 2, pan: -0.5 #if rand < 0.5
  #sleep 0.67
end

live_loop :synth_ch, sync: :kick do
  with_synth :saw do
    2.times do
      #   play_chord [:g3, :b3, :d4], amp: 6, pan: -0.2, release: 0.4 #if rand < 0.5
      #  sleep 1.5
    end
    #sleep 1
  end
end

live_loop :piszczala, sync: :kick do
  with_synth :dsaw do
    #play choose(scale(:e3, :minor_pentatonic )), release: 0.3, cutoff: rrand(60, 120), amp: 1 if rand < 0.4
    #sleep 0.5
  end
end