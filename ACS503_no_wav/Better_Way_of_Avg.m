% Import Data
[xx,fs] = audioread('S_plus_N_20.wav');
xx = xx(1:204800);
N  = length(xx);
Nrecs = 200;
Nfft = 1024;
dt = 1/fs; Trec = Nfft*dt; df = 1/Trec; % Derived parameters
NG = Nfft/2 + 1; % Number of samples in Gxx for Nfft even
Gxx = zeros(Nfft, 1); % Set up Gxx vector with zeros (but initially to the size of Sxx!)
n1 = 1; n2 = Nfft; % Index values for extracting time-domain record
T = N*dt;

for ii = 1:Nrecs
    xx_rec = xx(n1:n2); % Extract next time record (xx must be a column vector like ww)
    lsp = fft(xx_rec)*dt; % Window the record and find the linear spectrum
    Gxx = Gxx + abs(lsp).^2; % Add next record’s spectral density into accumulator
    n1 = n1 + Nfft; n2 = n2 + Nfft; % Advance the index values
end
% Complete averaging operation (and shorten Gxx to proper length)
Gxx = (2.0/Trec)*Gxx(1:NG)/Nrecs;
Gxx(1) = Gxx(1)/2.0; Gxx(end) = Gxx(end)/2.0; % Correct the end points 

rms = sqrt(sum(Gxx).*df)
