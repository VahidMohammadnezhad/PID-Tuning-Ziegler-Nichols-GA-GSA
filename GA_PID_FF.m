function FC =GA_PID_FF(x)
%define data
num=4.228; 
den=[1 2.14  9.276 4.228]; 
delay=0;
DP=1 ;
[n,d]=pade(delay,DP);
plant=tf(num,den)*tf(n,d);
%out plant sharing
clear n d num den delay DP prompt dlg_title num_lines def answer
    
%% Generate TF     
Kp=x(:,1);
Ki=x(:,2);
Kd=x(:,3);
s=tf([1 0],1);
C=Kp+Ki/s+Kd*s;
PC=C.*plant;
PC1=PC+1;
n=get(PC1,'num');
TF=PC;
set(TF,'den',n);
clear PC PC1 n C
%% Calculate FC of Star for GSA
for i=1:length(Kp)
    SI(i)=stepinfo(TF(i));
end
si=struct2cell(SI);
OV=cell2mat(si(5,:));
ST=cell2mat(si(2,:));
RT=cell2mat(si(1,:));
FC=OV+RT+ST;
FC(isinf(FC))=nan;
FC(isnan(FC))=10*max(FC);
FC=OV+RT+ST;
FC=FC';
clear SI si OV ST RT PV PT ms TF var %y t NIAE  
 end