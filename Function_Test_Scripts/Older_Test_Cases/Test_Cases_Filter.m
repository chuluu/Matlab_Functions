% Playground for building filters

A = 21;
%B = max_val;
if (A == 1) %Lab#2
    [poles,zeros,HF_2,Fd_2,hn_2,n_2] = show_filter_responses([1,0.1],[1,0,1],1000,500,20,1);
elseif (A == 2) %Lab#2
    [Ak,Bk,HF,Fd,hn,n] = show_filter_responses_pz([0,0],[-1i, 1i],1,1000,500,20,1); %[-0.5i,0.5i] 
elseif (A == 4) %Lab#2 High Pass
    [poles,zeros,HF_2,Fd_2,hn_2,n_2] = show_filter_responses([1,0.9],[1],1000,500,50,1);
elseif (A == 5) %Lab#2 Notch Filter
    [poles,zeros,HF_2,Fd_2,hn_2,n_2] = show_filter_responses([1],[0.5 0 0.5],1000,500,50,1);
elseif (A == 6) %Lab#2 Low Pass
    [poles,zeros,HF_2,Fd_2,hn_2,n_2] = show_filter_responses([1],[0.5, 0.5],1000,500,50,1);
elseif (A == 7) %Lab#2 Band Pass
    [Ak,Bk,HF,Fd,hn,n] = show_filter_responses_pz([0.7i,-0.7i],[-1, 1],1,1000,500,50,1); %[-0.5i,0.5i] 
    
elseif (A == 8) % FIR BandPass
    [Ak,Bk,HF,Fd,hn,n] = show_filter_responses_pz([0,0],[-0.75 1],3,1000,500,50,1); %[-0.5i,0.5i] 
elseif (A == 9) % FIR Double Notch
    [Ak,Bk,HF,Fd,hn,n] = show_filter_responses_pz([0,0,0,0],[0.498+0.867*1i, 0.498-0.867*1i, -0.498+0.867*1i, -0.498-0.867*1i],0.3326,360,1000,50,1); %[-0.5i,0.5i] 
elseif (A == 10) % Random
    [poles,zeros,HF_2,Fd_2,hn_2,n_2] = show_filter_responses([10 13],[54 27 12],50000,500,50,1);
elseif (A == 11) % Low Pass
    [Ak,Bk,HF,Fd,hn,n] = show_filter_responses_pz([0.8],[0],0.2,1000,1000,50,1); %[-0.5i,0.5i] 
elseif (A == 12) % Low Pass
    [Ak,Bk,HF,Fd,hn,n] = show_filter_responses_pz([0.7,0.7],[-0.05+0.95i,-0.05-0.95i],0.04489,1000,1000,50,1); %[-0.5i,0.5i] 
elseif (A == 13) % IIR Double Notch
    [Ak,Bk,HF,Fd,hn,n] = show_filter_responses_pz([.475+.8227i,.475-.8227i,-.475+.8227i,-.475-.8227i,-.95],[0.5+0.866*1i, 0.5-0.866*1i, -0.5+0.866*1i, -0.5-0.866*1i,-1],0.883,360,10000,60,10); %[-0.5i,0.5i] 
elseif (A == 14) % FIR Double Notch
    [Ak,Bk,HF,Fd,hn,n] = show_filter_responses_pz([0,0,0,0,0],[0.5+0.866*1i, 0.5-0.866*1i, -0.5+0.866*1i, -0.5-0.866*1i,-1],0.16667,360,10000,60,10); %[-0.5i,0.5i] 
elseif (A == 15) % Band Pass
    [Ak,Bk,HF,Fd,hn,n] = show_filter_responses_pz([.7+0.4838i,.7-0.4838i],[-1,1],0.138,50000,500000,50,1); %[] 
elseif (A == 16) % Unit sample
    [hn, n]=unit_sample_response([1], [1,0.8], 40, 1);
elseif (A == 17) % High Pass multiple zero
    [Ak,Bk,HF,Fd,hn,n] = show_filter_responses_pz([0,-0.4],[1,1i,-1i],0.138,50000,1000,50,1); %[-0.5i,0.5i] 
elseif (A == 18)
    [Ak,Bk,HF,Fd,hn,n] = show_filter_responses_pz([0.75*exp(i*(2*pi/3)),0.75*exp(-i*(2*pi/3))],[(1/0.75)*exp(i*(2*pi/3)),(1/0.75)*exp(-i*(2*pi/3))],1,44100,1000,50,1); %[-0.5i,0.5i] 
elseif (A == 19)
    [Ak,Bk,HF,Fd,hn,n,max_val] = show_filter_responses_pz([0.95*exp(i*(2*1000*pi/48000)),0.95*exp(-i*(2*1000*pi/48000)),0.95*exp(i*(2*2000*pi/48000)),0.95*exp(-i*(2*2000*pi/48000))],[exp(-i*((2*1000*pi)/48000)),exp(i*((2*1000*pi)/48000)),exp(-i*((2*2000*pi)/48000)),exp(i*((2*2000*pi)/48000))],1/B,48000,5000,50,1); %[-0.5i,0.5i]
elseif (A == 20)
    [Ak,Bk,HF,Fd,hn,n,max_val] = show_filter_responses_pz([0,-0.8],[1,exp(i*(2*5000*pi/48000)),exp(i*(-2*5000*pi/48000)),exp(i*(2*15000*pi/48000)),exp(-i*(2*15000*pi/48000))],1,48000,5000,50,1); %[-0.5i,0.5i]
elseif (A == 21)
    [Ak,Bk,HF,Fd,hn,n,max_val] = show_filter_responses_pz([0.8 + 0.125i,0.8-0.125i],[-0.4+0.4i,-0.4-0.4i],1/38,1000,5000,50,1); %[-0.5i,0.5i]
end

% FV Tool output
%fvtool([0.25,0,-0.25],[1,0.25,-0.5])


