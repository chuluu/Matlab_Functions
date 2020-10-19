function [mean_abs_error, mean_sq_error]=magnitude_response_error(HF,F,Fc)
%function [mean_abs_error, mean_sq_error]=magnitude_response_error(HF,F,Fc)
%   HF = the complex DTFT frequency response values (linear scale)
%   Fd = digital frequencies that match the freq response values
%   Fc = filter cutoff frequency (6dB)

% Start with All zeros for ideal HidealF;
HidealF=zeros(size(HF));

% Get all frequencies below cutoff given in the passed freq array F
passband_freq_indices=find(F<=Fc);
HidealF(passband_freq_indices)=1.0;
% Handle 2-sided spectrum
passband_freq_indices=find(F>=1-Fc);
HidealF(passband_freq_indices)=1.0;

% Convert to Ideal High-Pass Filter response if H(0)=0
[DCfreq,DCfreqindex]=min(abs(F));
if abs(HF(DCfreqindex))<0.4,  % If high pass filter
    HidealF=1.0-HidealF;
    disp(['High Pass Filter'])
end;

% Compute Mean Absolute Difference
abs_error=abs(abs(HidealF) - abs(HF));

mean_abs_error=sum(abs_error)/length(abs_error)

sq_error=(abs(HidealF)-abs(HF)).^2;

mean_sq_error=sum(sq_error)/length(sq_error)

figure(200)
plot(F,abs(HF),'LineWidth',2)
hold on
plot(F,abs(HidealF),'k','LineWidth',2)
hold off
xlabel('Digital Frequency')
ylabel('Magnitude')
grid on;
legend('Actual','Ideal')
text(mean(F),0.56,['Mean Abs Error =',num2str(mean_abs_error*100,'%0.3g'),'%'],'HorizontalAlignment','center')
text(mean(F),0.46,['Mean Sq Error =',num2str(mean_sq_error*100,'%0.3g'),'%'],'HorizontalAlignment','center')