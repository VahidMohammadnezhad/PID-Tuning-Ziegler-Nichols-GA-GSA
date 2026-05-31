clear, clc
options = optimoptions('ga','PopulationSize',100,'MaxGenerations',100,'Display','iter');
[PID,fval] = ga(@GA_PID_FF, 3,[],[],[],[],0,5,[],options);

[n,d]=pade(0,1);
plant=tf(4.228,[1 2.14  9.276 4.228])*tf(n,d);
s=tf([1 0],1);
C=PID(1)+PID(2)/s+PID(3)*s;
figure
step(feedback(plant,1),'r')
hold on
step(feedback(plant*C,1),'g')
legend('Step respons', 'Step respons with PID controller (GA)')