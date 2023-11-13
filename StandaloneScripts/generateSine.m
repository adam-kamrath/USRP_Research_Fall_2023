function sineData = generateSine(fs, num_of_samples, frequency, complex)
    sine = dsp.SineWave(SamplesPerFrame=num_of_samples, SampleRate=fs, Frequency=frequency, ComplexOutput=complex);
    sineData = sine();
    release(sine);
end