function subInfo=GetSubjectInfo_ENGL
%%
% By Daniel Rojas-Líbano, 
% Universidad Diego Portales (UDP)
% Facultad de Psicología
% Sept 2018

tit='Enter Info';
instrBox={'Subject name ','Gender (F o M)','Age (years)',...
    'Session Researcher ','Principal Investigator'};
opt.Resize='on';
opt.WindowStyle='normal';
opt.WindowSize=100;
wSize=repmat([1 50],size(instrBox,3),1);
defaultID={'First name - Last name','F','18','Researcher Name Goes Here','Professor Name Goes Here'};

subInfo=struct;
% write info
instrBox2=horzcat(instrBox,{'Fecha','LocalHost'});
for ii=1:numel(instrBox2)
    subInfo.id{ii,1}=instrBox2{ii};
end


% subInfo.id={instrBox{1};instrBox{2};instrBox{3};instrBox{4};instrBox{5};...
%     'Fecha';'Sistema';'Usuario';'LocalHost'};
subInfo.data=inputdlg(instrBox,tit,wSize,defaultID,opt);

% append date
rn=size(subInfo.data,1);
datetimestr=GetCurrDateTime();
subInfo.data{rn+1}=datetimestr;


% append computer info
% computerInfo=Screen('Computer');
[~,host]=system('hostname');
rn=size(subInfo.data,1);
subInfo.data{rn+1}=host;
% subInfo.data{rn+2}=computerInfo.processUserShortName;
% subInfo.data{rn+3}=computerInfo.localHostName;
end