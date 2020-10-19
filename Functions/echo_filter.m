function [echo_filter_hn] = echo_filter(Dk_delays_msec,alphak_gains,fs)
%Inputs: 
%Dk_delays_msec = array of delay points in msec
%alphak_gains = gain at each delay point
%fs = sampling rate
%Outputs:
%echo_filter_hn = the impulse response of the echo 

D = round(Dk_delays_msec*10^-3.*fs);
hn = [zeros(1,D(1)),alphak_gains(1)];

for n = 1:1:length(D)
    if (1 < n)
        Delay = D(n) - D(n-1);
        intermediate = [zeros(1,Delay),alphak_gains(n)];
        hn = [hn,intermediate]; 
    end
end

echo_filter_hn = hn';
end

