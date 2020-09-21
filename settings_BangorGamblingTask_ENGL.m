 
% By Daniel Rojas-Líbano, 
% Universidad Diego Portales (UDP)
% Facultad de Psicología
% Sept 2018

%%%%%%%%%%%%%%% General task Parameters %%%%%%%%%%%%%%%%%%%%%%%

ITI_s=2.5;  %inter- trial interval (seconds)
Wait_time_s=4; %Max time wait for subject's response within a trial (seconds)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

participantInfo=GetSubjectInfo_ENGL;

%%%%%%%%%%%%%% Bangor-specific Parameters %%%%%%%%%%%%%%%%%%%%%%%

Start_amount=2;  %amount of money given to participant at task start

%payoff schedule
payoff_schedule='Bowman_exact'; 
[Blocks_pay_sequences, Blocks_card_sequences]=GetBGTPaySequences(payoff_schedule);

n_trials=size(Blocks_pay_sequences,2);

c=clock;
timestart=[num2str(c(4)) '-' num2str(c(5))];

% data structure
data.info.Subject_ID_actual=participantInfo.data{1};
data.info.Subject_ID=GenRandomString;
data.info.Subject_Age=participantInfo.data{3};
data.info.Subject_Gender=participantInfo.data{2};
data.info.Group_ID=participantInfo.data{4};
data.info.Project=participantInfo.data{7};

data.info.Task='Bangor Gambling Task';
data.info.Start_amount=Start_amount;
data.info.payoff_schedule='Bowman_exact';
data.info.timestart=timestart;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 
% %%%%%%% settings %%%%%%%%%%%% 
KbName('UnifyKeyNames');    % keynames for all types of keyboard
% buttons to press
responseKeys={'Y','N','1','2','3','4','5','O','space','ESCAPE'};
KbCheckList=nan(size(responseKeys));
for k=1:length(responseKeys)
    KbCheckList(k)=KbName(responseKeys{k});
end
RestrictKeysForKbCheck(KbCheckList);


%%
[deviceIdKey,deviceNameKey]=GetKeyboardIndices;

device2useID=deviceIdKey(end);


