function [X,f] = MyFFT(x,Fs,shift,n)
% [X,f] = MyFFT(x,Fs,n)
% INPUTS:
% x     Data array.
% Fs    Sampling time (seconds).
% shift fft shift applied or not, (default = yes)
% n     zero pads, (degault = 0)
% OUTPUTS:
% X     Shifted and normalized FT of w.  Complex.  DC component located in
% the "middle".
% f     Array of continuous-time frequencies corresponding to each
% component of W.
N = length(x);      % Normalize by sample length.


% used to ignore arguements for fft shift and zero pad
if nargin < 3
    shift = 'y'; 
end

if nargin < 4
    n = 0;
end

% Begin code
if n == 0
    X = fft(x)./Fs;
else
    X = fft(x,n)./Fs;
end

if shift == 'y'
    X = fftshift(X);    % Put DC in the middle.
    if rem(N,2) == 0
        % even number of samples.
        f = Fs*((N/-2):(-1+N/2))/N;
    else
        % odd number of samples.
        f = Fs*(((N-1)/-2):((N-1)/2))/N;
    end
else
    if rem(N,2) == 0
        % even number of samples.
        f = Fs*(0:N-1)/N;
    else
        % odd number of samples.
        f = Fs*(0:N-1)/N; %df = Fs/N
    end  
  
end



% figure;
% subplot(2,1,1);
% plot(f,abs(X));
% title(['W',num2str(LIT),' Chart'])
% ylabel('Magnitude');
% subplot(2,1,2);
% plot(f,angle(X));
% ylabel('Phase');
% xlabel('Continuous-Time Frequency [Hz]');