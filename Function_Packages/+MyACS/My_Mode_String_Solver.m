function w_real = My_Mode_String_Solver(T,rho1,rho2,L,w,fig_num)
% w_real = My_Mode_String_Solver(T,rho1,rho2,L,w)
% Inputs: 
% T    = Tension constant for both
% rho1 = density of first string
% rho2 = density of second string
% L    = length of string
% w    = frequencies one wants to check for the modes
% Outputs:
% w_real = normal modes for the string
% Plot   = 

    % Set up step and loop, I know solutions should be around up to 15
    % since the first mode I found was about ~3. 3*4 = 12. so it should run up
    % to at least 12, but preferably higher for safety. Also, step between
    % values is low because if it is small, it will take a long time to run. 
    c1   = sqrt(T/rho1);
    c2   = sqrt(T/rho2);

    % Set up equations
    s = c1*tan(((w/c1)*(L/2))) + c2*(tan((w/c2)*(L/2)));

    % Apply function
    range = 100;
    w_real = MyGen.MyTranscendental_Solver(w,s,range);
    % syms w
    % s = c1*tan(((w/c1)*(L/2))) + c2*(tan((w/c2)*(L/2)));
    % soln = vpasolve(s==0,w)

    N = length(w_real);
    LW = (rho1/rho2)+1;
    for a = 1:N
        k1 = w_real(a)/c1;
        k2 = w_real(a)/c2;
        x1 = 0:0.001:L/2;
        x2 = (L/2 + 0.001):0.001:L;
        y1 = 2*1i*sin(k1*x1);
        if rho1 == rho2
        	y2 = -2*1i*((sin(k1*L/2)/sin(k2*L/2)))*sin(k2*(L-x2));
        else
            y2 = 2*1i*((sin(k1*L/2)/sin(k2*L/2)))*sin(k2*(L-x2));
        end

        if a == 1
            % Numerical problem sin()/sin() doesn't equal 1, so it doesn't plot
            y2 = zeros(1,length(x2));
        end
        
        % Figure yes or nah?
        if nargin < 6 % --> doesnt exist for figure

        else
            figure(fig_num);
            subplot(N,1,a); plot(x1,imag(y1),'Linewidth',1*LW); hold on;
            subplot(N,1,a);plot(x2,imag(y2),'Linewidth',2);
            title(['w',num2str(a),'= ',num2str(w_real(a))],'Fontsize',12);
            xlabel('distance (m)','Fontsize',12);
            ylabel('imag(y) (m)','Fontsize',12);
        end

    end
end

