// Musical With Impulse and 3 Delays

// Sound Chain

Impulse imp => ResonZ rez => Gain input => dac;

250 => rez.Q;
300 => rez.gain;
2.0 => input.gain;


Delay dly[3];

input => dly[0] => dac.left;
input => dly[1] => dac;
input => dly[2] => dac.right;

for (0 => int i; i < 3; i++)
{
    dly[i] => OneZero filt => dly[i];
    0.6 => dly[i].gain; // reverb mix
    (0.8 + i*0.3) ::second => dly[i].max => dly[i].delay;
}

[62, 60, 64, 67, 65, 69, 65, 72, 74, 76] @=> int notes[]; 
notes.cap() - 1 => int numNotes;

while (1)
{
    Std.mtof(notes[Math.random2 (0, numNotes)]) => rez.freq;
    1.0 => imp.next;
    0.4::second => now;
}
    