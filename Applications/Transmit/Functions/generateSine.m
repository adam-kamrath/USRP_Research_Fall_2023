function sineData = generateSine(fs, num_of_samples, frequency)
    sine = dsp.SineWave(SamplesPerFrame=num_of_samples, SampleRate=fs, Frequency=frequency, ComplexOutput=true);
    sineData = sine();
    release(sine);
end