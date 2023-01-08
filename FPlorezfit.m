function [fine_freq,Zspec_fit,Zwater,ZMT,Zamide,ZNOE,Zamine,ss]=FPlorezfit(freq, Zspec)
warning off; %#ok<*WNOFF>
% five pool lorentzian fit

fine_freq_step=(freq(2)-freq(1))/10;
fine_freq = freq(1):fine_freq_step:freq(end);

%CESTR
%starting points
start=[1    0.9 1.4 0    0.1 25 -2.0     0.025 0.5 3.5     0.02 3 -3.5      0.01 1.5 2.2].';
% start=[1    0.9 1.4 0    0.1 25 -0.0     0.025 0.5 3.5     0.02 3 -3.5      0.01 1.5 2.2].';%center MT
%lower boundaries
lb=[0.99     0.02 0.3 -1     0 10 -4     0 0.4 3     0 1 -4.5     0 1 1].';
% lb=[0.99     0.02 0.3 -1     0 10 -0.1     0 0.4 3     0 1 -4.5     0 1 1].';%center MT
%upper boundaries
ub=[1     1 10 1    1 100 -2     0.2 3 4    0.4 5 2     0.2 3.5 2.5 ].';
% ub=[1     1 10 1    1 100 0.1     0.2 3 4    0.4 5 2     0.2 3.5 2.5 ].';%center MT
% 

% for i=1:size(Zspec,1)
%     for j=1:size(Zspec,2)
%         for k=1:size(Zspec,3)
%             i=24;j=24;k=3;

Zspec_fine= csaps(freq, Zspec, 1, fine_freq);
f_fpl = @(m, f) (1 ...                    %base
    - m(2)./(1+4*((f-m(4))/m(3)).^2) ...    %water
    - m(5)./(1+4*((f-m(7))/m(6)).^2) ...    %MT
    - m(8)./(1+4*((f-m(10))/m(9)).^2) ...   %amide
    - m(11)./(1+4*((f-m(13))/m(12)).^2) ... %NOE
    - m(14)./(1+4*((f-m(16))/m(15)).^2));    %amine
ss = lsqcurvefit(f_fpl, start, fine_freq, Zspec_fine, lb, ub);
Zwater =1- ss(2)./(1+4*((fine_freq-ss(4))/ss(3)).^2);%water
ZMT =1- ss(5)./(1+4*((fine_freq-ss(7))/ss(6)).^2);%MT
Zamide =1- ss(8)./(1+4*((fine_freq-ss(10))/ss(9)).^2);%amide
ZNOE =1- ss(11)./(1+4*((fine_freq-ss(13))/ss(12)).^2);%NOE
Zamine =1- ss(14)./(1+4*((fine_freq-ss(16))/ss(15)).^2);%amine
Zspec_fit =1 ...
    - ss(2)./(1+4*((fine_freq-ss(4))/ss(3)).^2)...
    - ss(5)./(1+4*((fine_freq-ss(7))/ss(6)).^2)...
    - ss(8)./(1+4*((fine_freq-ss(10))/ss(9)).^2)...
    - ss(11)./(1+4*((fine_freq-ss(13))/ss(12)).^2)...
    - ss(14)./(1+4*((fine_freq-ss(16))/ss(15)).^2);

%         end
%     end
% end
