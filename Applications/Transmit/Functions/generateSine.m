function sineData = generateSine()
    clc;

    time_scope = timescope();
    sine = dsp.SineWave(SamplesPerFrame=21500, SampleRate=100000, Frequency=10000);
    sineData = sine();
    time_scope(sineData);
    disp(size(sineData));
    release(sine);
    release(time_scope);
end