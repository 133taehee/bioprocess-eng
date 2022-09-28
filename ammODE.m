function ddt = ammODE(t,d,celln0,tau,doub,ammrate,startvol,glucrate)

x0 = celln0;  % starting cell number
power = 0.695*tau^(-1.001);

ddt = zeros(4,1);

ddt(1) = (power*x0)*exp(power*t);
ddt(2) = (ammrate) * d(1) * t;
ddt(3) = (16000-startvol)/(doub*tau);
ddt(4) = (glucrate) * d(1) * t;