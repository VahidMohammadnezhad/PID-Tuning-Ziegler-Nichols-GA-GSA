function [FC sharing]=GSA_PID_FF(output,sharing)
%% Generate plant of system
if  output.counter==1
    num=[];den=[];
    while length(num)>=length(den)  
         prompt = {'Enter vector numerator:','Enter vector denominator:','Enter delay','Enter degree pade'};
         dlg_title = 'Input transfer function';
         num_lines = 1;
         def = {'4.228','[1 2.14  9.276 4.228]','0','1'};
         answer=inputdlg(prompt,dlg_title,num_lines,def);
         figure(100)
         close figure 100
         num=  str2num(answer{1,:}); %#ok<ST2NM>
         den=  str2num(answer{2,:}); %#ok<ST2NM>
         delay=str2num(answer{3,:}); %#ok<ST2NM>
         DP=   str2num(answer{4,:}); %#ok<ST2NM>
    end
    [n,d]=pade(delay,DP);
    plant=tf(num,den)*tf(n,d);
    sharing=plant;
else
    plant=sharing;
end
%out plant sharing
clear n d num den delay
%% output
if ~isempty(output.stop)
    FC=[];
    s=tf([1 0],1);
    CC=output.best_xyz(1)+output.best_xyz(2)/s+output.best_xyz(3)*s;
    figure
    %step(plant,'r')
    hold on
    step(feedback(plant,1),'r')
    step(feedback(plant*CC,1),'k')
    legend('Step respons', 'Step respons with PID controller (GSA)')
    hold off
else
    
%% Generate TF    
    clear FC
    Kp=output.xyz(:,1);
    Ki=output.xyz(:,2);
    Kd=output.xyz(:,3);
    s=tf([1 0],1);
    C=Kp+Ki/s+Kd*s;
    PC=C.*plant;
    PC1=PC+1;
    n=get(PC1,'num');
    TF=PC;
    set(TF,'den',n);
    clear PC PC1 n C Kp Ki Kd
%% Calculate FC of Star for GSA
    for p=1:output.size_population
        SI(p)=stepinfo(TF(p));
    end
    clear p
    si=struct2cell(SI);
    OV=cell2mat(si(5,:));
    ST=cell2mat(si(2,:));
    RT=cell2mat(si(1,:));
    %[y,t]=step(TF)
    %IAE=max(t)*(sum(abs(abs(y)-1))/length(y));
    % FC=(1./(OV/max(OV)+ST/max(ST)+RT/max(RT)+realmin))';%NIAE/max(NIAE)  maximize
    %FC=((1./(sqrt((OV.^2)+(ST.^2)+(RT.^2)+1)))+1).^-1;% minimize FF
    
    FC=OV+RT+ST;
    FC(isinf(FC))=nan;
    FC(isnan(FC))=10*max(FC);
    FC=FC';
    clear SI si OV ST RT PV PT ms TF var %y t NIAE
end
end


