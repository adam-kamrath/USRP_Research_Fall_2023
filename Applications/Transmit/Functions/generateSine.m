function sineData = generateSine(fs, num_of_samples)
    time_scope = timescope(SampleRate=fs);
    sine = dsp.SineWave(SamplesPerFrame=num_of_samples, SampleRate=fs, Frequency=166.66);
    sineData = sine();
    % time_scope(sineData);
    release(sine);
    % release(time_scope);
end