clear all;
close all;

tspan = [0 60] ; % time-span in hours

tau = 30;           %   doubling time
ammrate = 1.94E-9;  %   ammonia production rate umol/cell-h
glucrate = -102.26E-9;   
startvol = 5000;

doub = 2;       % number of doublings
cdensmL = 16E6;  % cells/mL
fvol = 16000;    % final volume L
celln = cdensmL * fvol * 1000;  % number of cells
celln0 = celln/(2^doub);

%   initial conditions, assuming starting volume of 5000 L


d0(1) = celln0;    %   number of cells
d0(2) = 0;       %   ammonia concentration umol
d0(3) = startvol;    %   starting volume
d0(4) = 0;         %    required glucose start


% Use ODE45 solver
[t,d] = ode45(@(t,d) ammODE(t,d,celln0,tau,doub,ammrate,startvol,glucrate),tspan,d0);

vol = (d(:,2)./5000)-5000;     %   ammonia umol divided by max 5000 umol/L
cconc = .001*d(:,1)./d(:,3);   %   cell conc per mL
aconc = d(:,2)./d(:,3); %   ammonia conc


% Plot results
figure(1);
hold on;

subplot(2,2,1)
plot(t,d(:,1),'-r.')
xlabel('Time (hours)');
ylabel('Cells total');

subplot(2,2,2)
plot(t,d(:,2),'-b.')
xlabel('Time (hours)');
ylabel('Ammonia (umol)');

% subplot(3,2,3)
% plot(t,vol,'-k.')
% xlabel('Time (hours)');
% ylabel('Min additional required vol (L)');

subplot(2,2,3)
plot(t,cconc,'-g.')
xlabel('Time (hours)');
ylabel('cell conc (cells/mL)');

% subplot(2,2,5)
% plot(t,d(:,4),'-c.')
% xlabel('Time (hours)');
% ylabel('Total gluc required (umol)');

subplot(2,2,4)
plot(t,aconc,'-m.')
xlabel('Time (hours)');
ylabel('Ammonia conc (umol/L)');
