use_bpm 140

##################### samples #####################
samples = "D:/Users/Mamal/Desktop/SAMPLE/bit/"

kick = samples+"kick.wav"
tom = samples+"tom.wav"
clap = samples+"clap.wav"
shaker = samples+"shake.wav"
hat = samples+"hat.wav"

################## mixer ##########################

f = false
t = true


################### aranz ###########################

#PATTERN 7 x8
mixer = {
  'kick' => t,
  'clap' => t,
  'shaker1' => f,
  'shaker2' => f,
  'melody' => t,
  'bass' => f,
  'arrpegrio' => t,
  'tom' => f,
  'keys' => f,
  'bass2' => t,
  'hat' => t
}
takt = 4
live_loop :aranz do
  #PATTERN 1
  sleep 1
end

################## melodyjki ######################

motyw1 = (ring :e5, :c5, :a4, :e5, :c5, :a4, :e5, :c5, :a4, :e5, :c5)

melody_part = [ (ring 0, 0, 1, 1,
                 1, 0, 1, 1,
                 1, 0, 1, 1,
                 1, 0, 1, 1 ), 0.5 ]

melody2_part = [ (ring 0, 0, 0, 0,
                  0, 0, 1, 1,
                  1, 0, 0, 0,
                  0, 0, 1, 1 ), 0.25 ]

shaker1_part = [ (ring 0) * 21 + (ring 1, 1, 1), 0.3333333 ]

hat_part = [
  (ring 1, 0, 0.5, 0) * 4  +
  (ring 0.7, 0.7, 0.7, 0.7) * 2 +
  (ring 1, 0, 0, 0) +
  (ring 0, 0, 0, 0),
0.25 ]

bass_line = :a1

bass2_melody =
  (ring :a1, :e2, :b2, :c3) * 2 +
  (ring :f1, :e1, :g2, :a2) * 3 +
  (ring :f1, :c1, :d2, :g2) +
  (ring :c1, :g1, :c2, :d2) +
  (ring :c1, :g1, :d2, :e2)
bass2_rhytm = [ (ring 1, 1, 1, 1), 0.5 ]

#chord_progression = (ring chord(:a3, :minor)) * 6, (ring [:f3, :g3, :c4]) * 2

kick_part = [ (ring 1, 0, 0, 1, 0, 0, 0, 0), 1 ]
#kick_part = [ (ring 1, 0, 0.7, 0, 1, 0, 0.7, 0), 1 ]

###################### LOOPS ###################################
live_loop :kick, sync: :aranz do
  if mixer["kick"]
    sample kick, amp: kick_part[0].tick
    sleep kick_part[1]
  else
    sleep takt
  end
end

live_loop :clap, sync: :aranz do
  if mixer["clap"]
    sleep 2
    sample clap, amp: 1.5
    sleep 2
  else
    sleep takt
  end
end

shaker_part = [ (ring 0, 0, 0, 1, 1, 1, 1, 0), 0.333333 ]
pan_shaker = (ring -8, -4, 0)
live_loop :shaker, sync: :aranz do
  if mixer["shaker1"]
    sample shaker, amp: shaker1_part[0].tick, rpitch: pan_shaker.look
    sleep shaker1_part[1]
  elsif mixer["shaker2"]
    sleep 1
  else
    sleep takt
  end
end

live_loop :hat, sync: :aranz do
  if mixer["hat"]
    sample hat, amp: hat_part[0].tick, rpitch: 4 + rand * 8
    sleep hat_part[1]
  else
    sleep takt
  end
end

live_loop :bass, sync: :aranz do
  if mixer["bass"]
    play bass_line, release: 4
    sleep 4
  else
    sleep takt
  end
end

live_loop :bass2, sync: :aranz do
  use_synth :tri
  if mixer["bass2"]
    play bass2_melody.tick, amp: bass2_rhytm[0].look * 0.3
    sleep bass2_rhytm[1]
  else
    sleep takt
  end
end

tom_part = [ (ring 0, 0, 0) * 12 + (ring 1, 1, 1), 0.33333 ]

live_loop :tom, sync: :aranz do
  if mixer["tom"]
    sample tom, amp: tom_part[0].tick, rpitch: pan_shaker.look*2
    sleep tom_part[1]
  else
    sleep takt
  end
end
live_loop :melody, sync: :aranz do
  if mixer["melody"]
    use_synth :dsaw
    with_fx :reverb do
      if melody_part[0].tick(:rhytm) == 1
        sound = motyw1.tick(:mel)
      end
      play sound, amp: melody_part[0].look(:rhytm) * 0.6, release: 0.09, pan: 0.5 #if rand < 0.9
      sleep melody_part[1]
    end
  else
    sleep takt
  end
end

live_loop :keys, sync: :aranz do
  if mixer["keys"]
    use_synth :dpulse
    with_fx :slicer, pulse_width: 0.3, wave: 1 do

      2.times do
        play_chord chord(:a3, :minor), release: 5, amp: 0.3
        sleep 3
      end
      sleep 2

      play_chord chord(:f3, :major), release: 5, amp: 0.3
      sleep 3
      play_chord chord(:g3, '6*9'), release: 5, amp: 0.3
      sleep 3
      play_chord chord(:c4, :major), release: 5, amp: 0.15
      sleep 2
    end
  else
    sleep takt
  end
end



live_loop :arrpegrio, sync: :aranz do

  if mixer["arrpegrio"]
    use_synth :piano
    play_pattern_timed scale(:a3, :minor_pentatonic, num_octaves: 2), 0.26, amp: 0.3, pan: -0.2
    play_pattern_timed scale(:a3, :minor_pentatonic, num_octaves: 1), 0.25, amp: 0.3, pan: -0.2
  else
    sleep takt
  end

end