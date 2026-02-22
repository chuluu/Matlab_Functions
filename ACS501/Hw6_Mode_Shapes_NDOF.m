%% 6 masses = 6 DOF
clc
clear

% Input number of DOF
N = 4;

%% Part A Find normal modes of system (6 modes Freqs)
n = 2:1:N;
m = 1:1:N;
w = 2*sin(m*pi/(2*(N+1)))';

for a = 1:N
    disp(['m = ',num2str(m(a)),': ', num2str(w(a)),'wo']);
end

disp([' ']);

%% Part B Determine Amplitude Ratios an/a1
for a = 2:N
    name_old = ['a',num2str(a),'/a1'];
    name{a} = name_old;
end

% disp(name)

for a = 1:N
    num = sin((m(a).*pi./(N+1)).*n);
    den = sin((m(a).*pi./(N+1)).*1);
    an_a1(a,:) = num./den;
    disp(['m = ',num2str(m(a)),': ', num2str(an_a1(a,:))]);
end
an_a1_plot = [ones(1,N)',an_a1];

for a = 1:N
    mode_n = an_a1_plot(a,:);
    subplot(N,1,a); plot([0,m,N+1],[0,mode_n,0],'r.','MarkerSize', 20);hold on;
    subplot(N,1,a); plot([0,m,N+1],[0,mode_n,0],'b');
    subplot(N,1,a); plot([0,m,N+1],zeros(1,N+2),'--k');
    title(['m = ',num2str(a)]);
    grid on;
    xlim([0 N+1])
    ylim([min(min(an_a1_plot))  max(max(an_a1_plot))]);
end