# drums patterns

use_debug false
use_bpm 100
samples = "D:/Users/Mamal/Desktop/SAMPLE/"

kicks = Dir["D:/Users/Mamal/Desktop/SAMPLE/513TubeDrumHitsB866_Wav_SP/513TubeDrumHits_Wav_SP/Samples/Kicks/*.wav"]
snares = Dir["D:/Users/Mamal/Desktop/SAMPLE/513TubeDrumHitsB866_Wav_SP/513TubeDrumHits_Wav_SP/Samples/Snares/*.wav"]
hats = Dir["D:/Users/Mamal/Desktop/SAMPLE/513TubeDrumHitsB866_Wav_SP/513TubeDrumHits_Wav_SP/Samples/Hats & Shakers/*.wav"]

#tylko 16-tki

define :make_beat do |kick, snr, hat, beat|


  in_thread do
    beat["kik_pat"].each do |smpl|
      sample kick, amp: smpl
      sleep 0.25
    end
  end

  in_thread do
    beat["snr_pat"].each do |smpl|
      sample snr, amp: smpl
      sleep 0.25
    end
  end
  in_thread do
    beat["hat_pat"].each do |smpl|
      sample hat, amp: smpl
      sleep 0.25
    end
  end
end

simple_beat = {
  "kik_pat" => [2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  "hat_pat" => [1, 0, 0.5, 0, 1, 0, 0.5, 0, 1, 0, 0.5, 0, 1, 0, 0.5, 0],
  "snr_pat" => [0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0]
}

james_brown = {
  "kik_pat" => [2, 0, 2, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 2, 0, 0],
  "hat_pat" => [1, 0.7, 1, 0.7, 1, 0.7, 1, 0.7, 1, 0.7, 1, 0.7, 1, 0.7, 1, 0.7],
  "snr_pat" => [0, 0, 0, 0, 2, 0, 0, 1, 0, 1, 0, 1, 2, 0, 0, 0]
}

funk2 = {
  "kik_pat" => [2, 0, 0, 3] + [0, 0, 2, 0] + [0, 0, 2, 2] + [0, 2, 0, 0],
  "hat_pat" => [0, 0.7, 1, 0] + [0, 0, 0, 0.5] + [0.7, 0, 0, 0] + [0, 0, 1, 0],
  "snr_pat" => [0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0]
}

use_random_seed 0
kick = rrand(0, kicks.count)
live_loop :beat do
  #(1..kicks.count).each do |l|
  #   4.times do
  #print l
  make_beat(kicks[6], snares[7], hats[15], james_brown)
  sleep 4
  #   end
  # end
end

use_synth :tb303
live_loop :squelch do
  n = (ring :e2, :e2, :e3, :g3).tick
  play n, release: 0.125, cutoff: 80, res: 0.1, wave: (ring 2, 2, 2).tick
  sleep 0.25
end