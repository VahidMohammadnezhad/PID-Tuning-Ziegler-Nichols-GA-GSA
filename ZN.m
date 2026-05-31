function [x]=ZN()
%% This code uses the classical Ziegler–Nichols tuning method which is 
%% an empirical technique for setting PID controller parameters.
%% input plant
def = {'4.228','[1 2.14  9.276 4.228]','0','1'};
prompt = {'Enter vector numerator:','Enter vector denominator:','Enter delay','Enter degree pade'};
dlg_title = 'Input transfer function';
num_lines = 1;
answer=inputdlg(prompt,dlg_title,num_lines,def);
num=  str2num(answer{1,:}); %#ok<ST2NM>
den=  str2num(answer{2,:}); %#ok<ST2NM>
delay=str2num(answer{3,:}); %#ok<ST2NM>
DP=   str2num(answer{4,:}); %#ok<ST2NM>
[n,d]=pade(delay,DP);
plant=tf(num,den)*tf(n,d);
s=tf([1 0],1);
%% zn
[Gm,Pm,Wg,Wp]=margin(plant);
Pu=2*pi/Wg;
Zp=0.5*Gm;
Cp=0.5*Gm;
Zpi=[0.45*Gm Pu/1.2];
Cpi=Zpi(1)*(1+(1/(Zpi(2)*s)));
Zpid=[0.6*Gm Pu/2 Pu/8];
Cpid=Zpid(1)*(1+(1/(Zpid(2)*s))+Zpid(3)*s);
[n,d]=tfdata(Cpid);

%% Export results
figure
step(feedback(plant,1),'r')
hold on
step(feedback(plant*Cpid,1),'b')
legend('Step respons', 'Step respons with PID controller (ZN)')
xx=cell2mat(n)./max(cell2mat(d));
x=[xx(2) xx(3) xx(1)];
end