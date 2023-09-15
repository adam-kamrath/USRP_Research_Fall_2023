function [carrier1, carrier0] = generateCarrierData(modData)
%%
% This function will take in the modulated
% data array and return the carrier signals
% to transmit out

carrier1 = ones(length(modData)*30,1);
carrier0 = zeros(length(modData)*30,1);
end