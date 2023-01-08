







function phildev=Ffitt1_err(params,x,data);

% for initial exponential decay
m0=params(1);
a0=params(2);
T1=params(3);
model=abs(m0)*abs(1-(1+a0)*exp(-x./T1));
% model=m0*abs(1-a0*exp(-x./T1)+exp(-x./T1));
error=model-data;
phildev=sum(error.^2);



% for initial exponential decay
m0=params(1);
a0=params(2);
T1=params(3);
model=abs(m0)*abs(1-(1+a0)*exp(-x./T1));
% model=m0*abs(1-a0*exp(-x./T1)+exp(-x./T1));
error=model-data;
phildev=sum(error.^2);