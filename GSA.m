%% This MATLAB code uses the Gravitational Search Algorithm (GSA) to 
%% optimize Fitness Functions
function varargout = GSA(varargin)
%start initialization code - DO NOT EDIT

% GSA M-file for GSA.fig
%      GSA, by itself, creates a new GSA or raises the existing
%      singleton*.
%
%      H = GSA returns the handle to a new GSA or the handle to
%      the existing singleton*.
%
%      GSA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GSA.M with the given input arguments.
%
%      GSA('Property','Value',...) creates a new GSA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GSA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GSA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GSA

% Last Modified by GUIDE v2.5 15-Sep-2011 23:35:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GSA_OpeningFcn, ...
                   'gui_OutputFcn',  @GSA_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Outputs to the command line
function varargout = GSA_OutputFcn(hObject, eventdata, handles) 
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Opening __ Define global variables
function GSA_OpeningFcn(hObject, eventdata, handles, varargin) 
         handles.FF=''; %variable that show Fitness Function
         handles.NV=[];%variable that show Number of Variables
         handles.PS=100;%variable that show Size of Population
         handles.SV=[0 1];%variable that show Span of Variable
         handles.G1=1;%by variable G2 & G1 calculate Gravitational constant
         handles.G2=1;%by variable G2 & G1 calculate Gravitational constant
         handles.NMM=1;%variable that show Number of Major mass 
         handles.TL=30;%variable that show Time Limit for stop algorithm
         handles.NM=Inf;%variable that show limit Number of Movement for stop algorithm
         handles.endFF=[];%variable that show acceptable Fitness function limit for stop algorithm
         handles.NMMconestant=-1;%for next condition at step RUN
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fitness Function 
function edit_FF_Callback(hObject, eventdata, handles) 
         par=get(hObject,'string');%Receive data
         if   isempty(par) %Do you have input? 
              msgbox('please input Fitness function' )
              handles.FF='';
              set(hObject,'String',handles.FF)
         else %update parameter
              handles.FF=par;
         end
guidata(hObject, handles);
function edit_FF_CreateFcn(hObject, eventdata, handles) 
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Number of Variables 
function edit_NOV_Callback(hObject, eventdata, handles)
         %Receive data
         par1=get(hObject,'String');
         par=str2double(par1);
         %Check Condition & update parameter
         switch 1 
              case isempty(par1)  %Do you have input?
                   handles.NV='';
                   set(hObject,'String',num2str(handles.NV))
                   msgbox('please input Number of variables ' )
              case isnan(par) %Your input is correct?     
                   errordlg(' Number of variables must be positive integer such as=5 ','Error','modal');
                   set(hObject,'String',num2str(handles.NV))
              case par<1 %Whether the input number is eaual or larger than one?
                   errordlg('Number of variables must be eaual or larger than one ','Error','modal');
                   set(hObject,'String',num2str(handles.NV))
              case mod(par,1)~=0 %Whether input is integer?
                   errordlg('Number of variables must be integer such as=5 ','Error','modal');
                   set(hObject,'String',num2str(handles.NV))
             otherwise %update parameter
                   handles.NV=par;
         end
guidata(hObject, handles);
function edit_NOV_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Population Size
function Tag_PS_Callback(hObject, eventdata, handles)
         if   get(hObject,'Value')~=get(hObject,'Max'); %Default mode
              handles.PS=100;
              set(handles.edit_PSDC,'string',num2str(handles.PS));
              set(hObject,'String','Population size (Default)');
         else %Custom mode
              set(hObject,'String','Population size (Custom)');
         end
guidata(hObject,handles)
function Tag_PS_CreateFcn(hObject, eventdata, handles)
guidata(hObject,handles)

%%
function edit_PSDC_Callback(hObject, eventdata, handles)
         if   get(handles.Tag_PS,'Value')~=get(handles.Tag_PS,'Max'); %Default mode
              handles.PS=100;
              set(hObject,'string',num2str(handles.PS));
         else %Custome mode
              %Receive data
              par1=get(hObject,'String');
              par=str2double(par1);
              %Check Condition & update parameter
              switch 1
                   case isempty(par1)  %Do you have input?
                        errordlg('Population size can not empty' )
                        set(hObject,'string',num2str(handles.PS));
                   case isnan(par)  %Your input is correct?
                        errordlg('Population size  must be positive integer such as=100 ','Error','modal');
                        set(hObject,'String',num2str(handles.PS))
                   case par<=1; %Whether the input number is  larger than one?
                        errordlg('Population size must be larger than one','Error','modal');
                        set(hObject,'String',num2str(handles.PS))   
                   case mod(par,1)~=0 %Whether input is integer?     
                        errordlg('Population size must be integer such as=100 ','Error','modal');
                        set(hObject,'String',num2str(handles.PS))     
                   otherwise %Update parameter   
                        handles.PS=par;
              end
         end
guidata(hObject, handles);
function edit_PSDC_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Span of Variable
function Tag_SV_Callback(hObject, eventdata, handles)
         if   get(hObject,'Value')~=get(hObject,'Max'); %Default mode
              handles.SV=[0 1];
              set(handles.edit_SOVDC,'string',['[' num2str(handles.SV) ']']);
              set(hObject,'String','Span of variable (Default)');
         else %Custome mode
              set(hObject,'String','Span of variable (Custom)');
         end
guidata(hObject,handles)
function Tag_SV_CreateFcn(hObject, eventdata, handles)
guidata(hObject,handles)

%%
function edit_SOVDC_Callback(hObject, eventdata, handles)
         if   get(handles.Tag_SV,'Value')~=get(handles.Tag_SV,'Max'); %Default mode
              handles.SV=[0 1];
              set(hObject,'string',['[' num2str(handles.SV) ']']);
         else %Custome mode
              %Receive data
              par1=get(hObject,'String');
              par=str2num(par1);
              var=size(par);
              %Check Condition & update parameter
              switch 1 
                   case isempty(par1) %Do you have input?
                        errordlg('Span of variable can not empty' )
                        set(hObject,'string',['[' num2str(handles.SV) ']']);
                   case mod(var(2),2)~=0 || length(var)~=2 || var(1)~=1%is dimension of Spans variable correct?
                        errordlg('dimension of Spans variable must be 1*n that n=2 for all variables or n=2*Number of variables fort each varibles','Error','modal');
                        set(hObject,'String',['[' num2str(handles.SV) ']'])
                   otherwise %update parameter
                        handles.SV=par;
                        set(hObject,'String',['[' num2str(handles.SV) ']'])
              end
         end 
guidata(hObject, handles);    
function edit_SOVDC_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Gravitational constant
function Tag_G_Callback(hObject, eventdata, handles)
         par=get(hObject,'Value');%Receive data
         switch par %determine type of Gravitational constant
              case 1 %Exponential mode
                   set(handles.text_RaG,'String','G=G1*exp(-t/T) ')
                   set(handles.edit_G2,'String',num2str(handles.G2))
              case 2 %fraction mode
                   set(handles.text_RaG,'String','G=G1/(1+ t/T) ')
                   set(handles.edit_G2,'String',num2str(handles.G2))
              case 3 %conestant mode
                   set(handles.text_RaG,'String','G=G1')
                   set(handles.edit_G2,'String','')
         end
guidata(hObject, handles);
function Tag_G_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);


%%
function edit_G1_Callback(hObject, eventdata, handles)
         %Receive data
         par1=get(hObject,'string');
         par=str2double(par1);
         %Check Condition & update parameter
         switch  1
             case  isempty(par1) %Do you have input?
                   errordlg('coefficients Gravitational constant can not empty' )
                   set(hObject,'string',num2str(handles.G1));
             case  isnan(par)  %Your input is correct?
                   errordlg('G1 must be positive Number suach as=5','Error','modal');
                   set(hObject,'string',num2str(handles.G1));
             case  par<=0  %Whether the input number is positive?
                   errordlg('G1 must be positive(G1>0)','Error','modal'); 
                   set(hObject,'string',num2str(handles.G1));
             otherwise %update parameter
                   handles.G1=par;
         end            
guidata(hObject, handles);
function edit_G1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);


%%
function edit_G2_Callback(hObject, eventdata, handles)
         %Receive data
         par1=get(hObject,'string');
         par=str2double(par1);
         var=get(handles.Tag_G,'Value');
         %Check Condition and update parameter
         switch var  
              case 1 %Exponential mode
                   switch 1
                        case isempty(par1) %Do you have input?
                             errordlg('coefficients Gravitational constant can not empty' )
                             set(hObject,'string',num2str(handles.G2));
                        case isnan(par) %Your input is correct?
                             errordlg('T must be positive Number suach as=5','Error','modal');
                             set(hObject,'string',num2str(handles.G2));
                        case par<=0  %Whether the input number is positive?
                             errordlg('T must be positive(T>0)','Error','modal'); 
                             set(hObject,'string',num2str(handles.G2));
                       otherwise %update parameter
                             handles.G2=par;
                   end
              case 2 %fraction mode
                   switch 1
                        case isempty(par1)  %Do you have input?
                             errordlg('coefficients Gravitational constant can not empty' )
                             set(hObject,'string',num2str(handles.G2));
                        case isnan(par) %Your input is correct?
                             errordlg('T must be positive Number suach as=5','Error','modal');
                             set(hObject,'string',num2str(handles.G2));
                        case par<=0  %Whether the input number is larger than zero?
                             errordlg('T must be positive(T>0)','Error','modal'); 
                             set(hObject,'string',num2str(handles.G2));
                       otherwise %update parameter
                            handles.G2=par;
                   end
              case 3 %conestant mode
                   set(hObject,'string','');
                   msgbox('coefficient T not used in Gravitational constant' )
         end                           
guidata(hObject, handles);
function edit_G2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Number of Major Mass
function Tag_NMM_Callback(hObject, eventdata, handles)
         %Receive data
         par=get(hObject,'Value');
         switch par %determine type of Number of Major Mass
              case 1 %Exponential mode
                   set(handles.Tag_RaNMM,'String','NMM=0.1*N+(0.9*N*exp(-t/T));N=Population size')
                   handles.NMMconestant=-1;%not active in the next shart
              case 2 %fraction mode
                   set(handles.Tag_RaNMM,'String','NMM=0.1*N+(0.9*N/(t/T+1);N=Population size')
                   handles.NMMconestant=-1;%not active in the next shart
              case 3 %conestant mode
                   set(handles.Tag_RaNMM,'String','NMM=T ;T<=Population size ')
                   handles.NMM=fix(handles.NMM);
                   if handles.NMM==0 %Number of Major Mass can not equal zero
                      handles.NMM=1;
                   end
                   handles.NMMconestant=handles.NMM;%use in the next condition in RUN
                   set(handles.edit_NMM,'String',num2str(handles.NMM))
         end
guidata(hObject, handles);
function Tag_NMM_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);


%%
function edit_NMM_Callback(hObject, eventdata, handles)
         %Receive data
         var=get(handles.Tag_NMM,'Value');
         par1=get(hObject,'string');
         par=str2double(par1);
         %Check Condition & update parameter
         switch var 
              case 1 %Exponential mode 
                   switch 1
                        case isempty(par1) %Do you have input?
                             errordlg('coefficients Number of major mass can not empty' )
                             set(hObject,'string',num2str(handles.NMM));
                        case isnan(par) %Your input is correct?
                             errordlg('T must be positive number suach as=5','Error','modal');
                             set(hObject,'string',num2str(handles.NMM));
                        case par<=0 %Whether the input number is positive?
                             errordlg('T must be positive(T>0)','Error','modal'); 
                             set(hObject,'string',num2str(handles.NMM));
                        otherwise %update parameter
                             handles.NMM=par;
                   end  
             case 2 %fraction mode
                   switch 1
                        case isempty(par1) %Do you have input?
                             errordlg('coefficients Number of major mass can not empty' )
                             set(hObject,'string',num2str(handles.NMM));
                        case isnan(par) %Your input is correct?
                             errordlg('T must be positive number suach as=5','Error','modal');
                             set(hObject,'string',num2str(handles.NMM));
                        case par<=0 %Whether the input number is positive?
                             errordlg('T must be positive(T>0)','Error','modal'); 
                             set(hObject,'string',num2str(handles.NMM));
                        otherwise %update parameter
                             handles.NMM=par;
                   end  
             case 3 %conestant mode
                   switch 1
                        case isempty(par1) %Do you have input?
                             errordlg('coefficients Number of major mass can not empty' )
                             set(hObject,'string',num2str(handles.NMM));
                        case isnan(par) %Your input is correct?
                             errordlg('K must be positive number suach as=5','Error','modal');
                             set(hObject,'string',num2str(handles.NMM));
                        case par<=0 %Whether the input number is positive?      
                             errordlg('T must be positive(T>0)','Error','modal'); 
                             set(hObject,'string',num2str(handles.NMM));
                        case mod(par,1)~=0  %Whether input is integer? 
                             errordlg('T must be integer','Error','modal'); 
                             set(hObject,'string',num2str(handles.NMM));
                        otherwise %update parameter
                             handles.NMM=par;
                             handles.NMMconestant=par;
                   end
         end                  
guidata(hObject, handles);
function edit_NMM_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% percent of new generate
function Tag_Generate_Callback(hObject, eventdata, handles)
         %Receive data
         par=fix(100*get(hObject,'Value'));
         set(handles.text_Generate,'string',par);
guidata(hObject,handles)
function Tag_Generate_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
guidata(hObject,handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Stopping algorithm_ Time
function edit_Time_Callback(hObject, eventdata, handles)
         %Receive data
         par1=get(hObject,'String');
         par=str2double(par1);
         %Check Condition & update parameter
         switch 1 
              case isempty(par1) %Do you have input? 
                   errordlg('Time limit can not empty' )
                   set(hObject,'string',['[' num2str(handles.TL) ']']);
              case isnan(par) %Your input is correct?
                   errordlg('Time limit must be positive number such as=5 ','Error','modal');
                   set(hObject,'String',num2str(handles.TL))
              case par<=0 %Whether the input number is positive?   
                   errordlg('Time iimit must be positive','Error','modal');
                   set(hObject,'String',num2str(handles.TL))
              otherwise %Update parameter
                   handles.TL=par;
         end     
guidata(hObject, handles);
function edit_Time_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Stopping algorithm_ number of movement
function Tag_NOM_Callback(hObject, eventdata, handles)
         if   get(hObject,'Value')~=get(hObject,'max')%Default mode
              handles.NM=inf;
              set(handles.edit_NOM,'String',num2str(handles.NM));
              set(hObject,'string','Number of movement(Default)');
         else
              set(hObject,'string','Number of movement(Custome)');    
         end
guidata(hObject, handles);
function Tag_NOM_CreateFcn(hObject, eventdata, handles)
guidata(hObject, handles);


%%
function edit_NOM_Callback(hObject, eventdata, handles)
         if   get(handles.Tag_NOM,'Value')~=get(handles.Tag_NOM,'max') %default mode
              handles.NM=inf;
              set(hObject,'String',num2str(handles.NM)); 
              msgbox(' please first active this condition ');
         else %coustom mode
              %Receive data
              par1=get(hObject,'String');
              par=str2double(par1);
              %Check Condition & update parameter
              switch 1 
                   case isempty(par1) %Do you have input?      
                        errordlg('number of movement can not empty' )
                        set(hObject,'string',num2str(handles.NM));
                   case isnan(par) %Your input is correct?
                        errordlg(' number of movement must be positive intrger such as=5 ','Error','modal');
                        set(hObject,'String',num2str(handles.NM))
                   case par<=0; %Whether the input number is positive?   
                        errordlg('number of movement must be positive','Error','modal');
                        set(hObject,'String',num2str(handles.NM))
                   case mod(par,1)~=0 %Whether input is integer?
                        errordlg('number of movement must be integer such as 5 ','Error','modal'); 
                        set(hObject,'string',num2str(handles.NM));
                   otherwise %update parameter
                        handles.NM=par;
              end 
         end
guidata(hObject, handles);
function edit_NOM_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Stopping algorithm_Fitness function
function Tag_FF_Callback(hObject, eventdata, handles)
         if   get(hObject,'Value')~=get(hObject,'max')%default mod
              handles.endFF=[];
              set(handles.edit_endFF,'String',num2str(handles.endFF)); 
         else %coustom mode
              handles.endFF=0;
              set(handles.edit_endFF,'String',['[' num2str(handles.endFF) ']']);
         end
guidata(hObject,handles)
function Tag_FF_CreateFcn(hObject, eventdata, handles)
guidata(hObject,handles)


%%
function edit_endFF_Callback(hObject, eventdata, handles)
         if   get(handles.Tag_FF,'Value')~=get(handles.Tag_FF,'max')%default mod
              handles.endFF=[];
              set(hObject,'String',num2str(handles.endFF));
              msgbox(' please first active this condition ');
         else %Custome mode
              %Receive data
              par1=get(hObject,'String');
              par=str2num(par1);
              sizepar=size(par);
              %Check Condition & update parameter
              switch 1 
                   case isempty(par1) %Do you have input?  
                        errordlg('Fitness function limit can not empty' )
                        set(hObject,'string',['[' num2str(handles.endFF) ']']);
                   case sizepar(1,1)~=1 || length(sizepar)~=2 %Your input is correct?
                        errordlg('dimension of Fitness function must be 1*n that n=number of Fitness function ','Error','modal');
                        set(hObject,'String',['[' num2str(handles.endFF) ']'])
                   otherwise %update parameter
                        handles.endFF=par;
                        set(hObject,'String',['[' num2str(handles.endFF) ']'])
              end 
         end
guidata(hObject,handles)
function edit_endFF_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles)


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Run
function Tag_Run_Callback(hObject, eventdata, handles)
%% 1-Check Condition
clc
sizeSV=size(handles.SV);
switch 1
    case length(handles.FF)==0 %#ok<ISMT> %Fitness function can not empty for Run 
         errordlg('Fitness function can not empty for Run  ','Error','modal');
    case length(handles.NV)==0 %#ok<ISMT> %number of variables can not empty for Run
         errordlg('number of variables can not empty for Run  ','Error','modal');
    case sizeSV(2)~=2*handles.NV && sizeSV(2)~=2%is span of variables cortect?
         errordlg(' Span of  variable must be 1*2 for all variables or 1*2n that n=number of variables','Error','modal');
    case handles.NMMconestant>handles.PS% Number of major mass must be <=size of population
         errordlg('must Number of major mass <= population size  ','Error','modal');
    otherwise 
    %out sizeSV  
%% 2-reset output
   set(handles.text_elpasedTime,'String','');
   set(handles.text_bestrespone,'String','');
   set(handles.text_bestFF,'String','');
   set(handles.text_WhyStop,'String','');
%%  run program
%% 3-Generate initial population
         xyz=rand(handles.PS,handles.NV);
         if   sizeSV(2)==2 %use span of variables for all variables
              SV2=handles.SV;
              span=abs(handles.SV(2)-handles.SV(1));
              xyz=xyz*span+min(handles.SV);
         else %any variable has a span separate from other variable
              SV2=reshape(handles.SV,2,handles.NV)';
              span=abs(SV2(:,2)-SV2(:,1));
              for  p=1:handles.NV
                   xyz(:,p)=xyz(:,p)*span(p)+min(SV2(p,1),SV2(p,2));
              end
         end
         %out xyz SV2 span
         clear  p          
%% 4-Define initial parameter
         allow=[];%this variable determaine that the algorithm starting or stoping
         counter=0;%this variable showing number of repeating algorithm
         sharing=[]; %usin for no loss plant bettwen algrithm and M_file
         out=[handles.FF '(output,sharing)'];%use for calling M-file
         output.xyz=[];%this variable showing the coordinate of responses
         output.counter=0;%this variable this variable showing that number of repeating algorithm
         output.best_xyz=[];%this variable showing the best of responses in yet
         output.best_FC=[];%this variable showing the best of Fitness Function
         output.time=0;%this variable showing elpased time
         output.Gravitational_constant=[];%this variable showing Gravitational constant in any repeat algorithm
         output.number_mass_major=[];%this variable showing number of major mass in any repeat algorithm
         output.number_variables=handles.NV;%this variable showing number of variable
         output.size_population=handles.PS;%this variable showing size of population
         output.spans_variables=SV2;%his variable showing spans of parameter
         output.stop=[];%by this variblea we determaine what stopping algorithm
         %out is clear 
%% 5-Minimize or Maximize Fitness Function
         %bay this variables we define the Maximize FF(1) or Minimize FF(0)
         max_min=(get(handles.Tag_MaFF,'Value')==get(handles.Tag_MaFF,'max'));
         %out max_min
%% 6-Persent of new generate
         PG=(fix(100*get(handles.Tag_Generate,'Value')))/100;
         %out PG
%% 7-start algorithm  
         tic%start time  
         while isempty(allow) %if allow be empty the algorithm continuance
              counter=counter+1
              t=toc;
              %out t            
%% 7.1-select Gravitational constant                       
              switch 1
                   case 1==get(handles.Tag_G,'Value');
                        G=handles.G1*exp(-t/handles.G2);
                   case 2==get(handles.Tag_G,'Value');
                        G=handles.G1/(1+(t/handles.G2));
                   case 3==get(handles.Tag_G,'Value');
                        G=handles.G1;
              end  
              %out G              
%% 8-select NMM major mass
              switch 1
                   case 1==get(handles.Tag_NMM,'Value');
                        NMM=0.1*handles.PS+(0.9*handles.PS*exp(-t/handles.NMM));
                        NMM=ceil(NMM);
                   case 2==get(handles.Tag_NMM,'Value');
                        NMM=0.1*handles.PS+(0.9*handles.PS/(1+t/handles.NMM));
                        NMM=ceil(NMM);
                   case 3==get(handles.Tag_NMM,'Value');
                        NMM=handles.NMM;
              end
              %out NMM 
%% 9-check condition for stoping algorithm befor recallig Fitness Function
              switch 1
                   case t>handles.TL;
                        allow='time end';
                   case counter>handles.NM;
                        allow='Number of movement end';  
                   case counter~=1 && get(handles.Tag_FF,'Value')==get(handles.Tag_FF,'max')%custom
                        switch 1
                             case  max_min==1  && isempty(find(bestFCxyz<handles.endFF,1)) %maximization
                                   allow=['Fitness Function > ?' num2str(handles.endFF)];
                             case  max_min==0  && isempty(find(bestFCxyz>handles.endFF,1)) %minimization
                                   allow=['Fitness Function < ?' num2str(handles.endFF)];
                        end
                        
              end               
%% 10-send data to Fitness function and receive value of Fitness function
              %update data for send
               output.xyz=xyz;
               output.counter=counter;       
               if   counter==1
                    output.best_xyz=[];
                    output.best_FC=[];
               else
                    output.best_xyz=xyz(1,:); 
                    output.best_FC=bestFC;
               end 
               output.time=t;
               output.Gravitational_constant=G;
               output.number_mass_major=NMM; 
               output.stop=allow;
               %calling Fitness function
               clear FC
               [FC sharing]=eval(out); %#ok<NASGU>
               sizeFC=size(FC);
               %out FC sharing sizeFC
%% 11-step 9 + check receive value of Fitness function after recallig Fitness Function
               switch 1
                   case ~isempty(allow)%view step 7
                        %stop algorithm sucsessful
                   case ~isempty(find(isnan(FC),1))
                        allow='FC is nan';% stop algorithm
                        errordlg('stop algorithm==> FC is nan','Error','modal');   
                   case max(FC)==min(FC)
                        allow='max(FC)==min(FC)'; % stop algorithm   
                   case length(sizeFC)~=2
                        allow='dimension of FC not correct';% stop algorithm
                        errordlg('stop algorithm==> dimension of FC must be n*m;n=size Population, m=number of fitness function','Error','modal');
                   case ~isempty(find(isinf(abs(FC)),1))
                         allow='FC is inf';% stop algorithm
                        errordlg('stop algorithm==> FC is inf','Error','modal');   
                   otherwise 
%% 12-Calculate Mass of star && sort of MS be hmrah zarayeb xyz
                        clear MS
                        switch 1
                             case   sizeFC(2)==1  %state one fitness function
                                  if   max_min==1 %maximaize
                                       ms=((FC-min(FC))./(max(FC)-min(FC)))';
                                       MS=((handles.PS*ms)/sum(ms))';%the mass of responses
                                       bestFC=max(FC);
                                       else %minimize
                                       ms=((FC-max(FC))./(min(FC)-max(FC)))';
                                       MS=((handles.PS*ms)/sum(ms))';%the mass of responses
                                       bestFC=min(FC);
                                  end
                                  %%sort of MS be hmrah zarayeb xyz
                                  msxyz=[MS,xyz];
                                  MSxyz=sortrows(msxyz,-1);
                                  MS=MSxyz(:,1);
                                  xyz=MSxyz(:,2:end);           
                                  clear msxyz MSxyz ms      
                            case  sizeFC(2)~=1%state multi fitness function
                                      FCxyz=[FC,xyz];               
                                      if   max_min==1 %maximaize
                                           P=-(1:sizeFC(2));
                                           FCXYZ=sortrows(FCxyz,P);
                                      else %minimize
                                           P=(1:sizeFC(2));%deternine tartib sort
                                           FCXYZ=sortrows(FCxyz,P);
                                      end
                                      bestFC=FCXYZ(1,1:sizeFC(2));
                                      xyz=FCXYZ(:,sizeFC(2)+1:end);
                                      MS=(handles.PS:-1:1)';
                                  clear FCxyz FCXYZ P
                        end
                       %out  bestFC MS xyz          
%% 13-Calculate distance
                        Dist=squareform(pdist(xyz));                    
%% 14-moving stars                       
                        Randi=rand(handles.PS);
                        V=zeros(handles.PS,handles.NV);
                        apt=[];
                        for  p=1:handles.PS
                        ap=zeros(1,handles.NV);
                        for  q=1:NMM
                             if   p~=q
                                  ap=ap+(G.*Randi(p,q).*MS(q)./((Dist(p,q)^2+0.000001))).*(xyz(q,:)-xyz(p,:));
                             end
                        end 
                        apt=[apt;ap]; %#ok<AGROW>
                        clear ap
                        end
                        V=rand(handles.PS,handles.NV).*V+apt;
                        xyz=xyz+V;
                        clear apt ap Randi NMM G q p Dist
%% determine the 'MS0' and 'span not correct' for two next step
                        parmin=0;
                        parmax=0;
                        if   sizeSV(2)==2 
                             parmin=length(find(xyz<min(handles.SV)));
                             parmax=length(find(xyz>max(handles.SV)));
                        else
                             for  p=1:handles.NV
                                  parmin=max(parmin,length(find(xyz(:,p)<min(SV2(p,:)))));
                                  parmax=max(parmax,length(find(xyz(:,p)>max(SV2(p,:)))));                                 
                             end
                        end
                        notspan=max(parmin,parmax);
                        clear parmin parmax                           
%% 15-delet the Ms has less mass & make random star for replace with this
                        MS0=fix(PG*handles.PS);
                        if   MS0>notspan    
                             MS0=MS0-notspan;
                             xyz(handles.PS-MS0+1:handles.PS,:)=[];                        
                             var=rand(MS0,handles.NV);
                             if   sizeSV(2)==2 %use span of variables for all variables
                                  var=var*span+min(handles.SV);
                             else %any variable has a span separate from other variable
                                  for  p=1:handles.NV
                                       var(:,p)=var(:,p)*span(p)+min(SV2(p,1),SV2(p,2));
                                  end
                             end      
                             xyz=[xyz;var]; %#ok<AGROW>
                        end
                        clear var p  MS0                    
%% 16-check the span of variables
                        if   sizeSV(2)==2 %use span of variables for all variables
                             xyz(find(xyz<min(handles.SV)))=min(handles.SV); %#ok<FNDSB>
                             xyz(find(xyz>max(handles.SV)))=max(handles.SV); %#ok<FNDSB>
                        else %any variable has a span separate from other variable
                             for  p=1:handles.NV
                                  xyz((find(xyz(:,p)<min(SV2(p,:)))),p)=min(SV2(p,:)); %#ok<FNDSB>
                                  xyz((find(xyz(:,p)>max(SV2(p,:)))),p)=max(SV2(p,:)); %#ok<FNDSB>
                             end
                     
                        end  
               end 
%% result miany
         end 
%% 14-final result
         if counter~=1
         set(handles.text_elpasedTime,'String',num2str(t));
         set(handles.text_bestrespone,'String',num2str(xyz(1,:)));
         set(handles.text_bestFF,'String',['[' num2str(bestFC) ']']);
         set(handles.text_WhyStop,'String',allow);
         end
end
guidata(hObject,handles)
function Tag_Run_CreateFcn(hObject, eventdata, handles)
guidata(hObject,handles)

%%


% --- Executes during object creation, after setting all properties.
function uipanel11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in checkbox10.


