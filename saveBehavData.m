function saveBehavData(task,data)

% generate file name
datetimestr=GetCurrDateTime();
folder=['.' filesep 'data'];
filename=[folder filesep task 'data_' data.info.Participant_ID(1:2) '_' datetimestr(1:10)];

temp=regexp(datetimestr,'_','split');

% write data
fileID = fopen([filename '.txt'],'w');
fprintf(fileID,'%s\t%s\r\n','Fecha (yyyy_mm_dd):',datetimestr(1:10));
fprintf(fileID,'%s\t%s\r\n','Hora inicio:',data.info.timestart);
fprintf(fileID,'%s\t%s\r\n','Hora fin:',temp{4});
fprintf(fileID,'%s\t%s\r\n','Tarea:', data.info.Task);
fprintf(fileID,'%s\t%s\r\n','Participante:',data.info.Participant_ID);
fprintf(fileID,'%s\t%s\r\n','Genero:',data.info.Gender);
fprintf(fileID,'%s\t%s\r\n','Edad:',data.info.Age);
fprintf(fileID,'%s\t%s\r\n','Grupo:', data.info.Group);
% fprintf(fileID,'%s\t%s\r\n\r\n','Proyecto:', data.info.Project);

if strcmpi(task,'IGT')  %Iowa Gambling Task
    
    fprintf(fileID,'%s %s\r\n','Dinero inicial:',num2str(data.info.Start_amount));
    fprintf(fileID,'%s %s\r\n\r\n','Secuencia de ganancias:',data.info.payoff_schedule);
    fprintf(fileID,'%s\t%s\t%s\r\n','Elecc','Dinero','TR (s)');
    fprintf(fileID,'%g\t%g\t%g\r\n',([data.vars.Choice_seq data.vars.Money_seq data.vars.RT_seq])');
    fprintf(fileID,'%s %s\r\n','======', '======');
    fprintf(fileID,'%s\t%s\r\n','Trial','Reporte');
    fprintf(fileID,'%g\t%g\r\n',data.vars.responses_subj_reports');
    fprintf(fileID,'%s\r\n','Pregunta y alternativas');
    fprintf(fileID,'%s\r\n',data.info.subject_report_choices{1});
    fprintf(fileID,'%s\r\n',data.info.subject_report_choices{2});
    fprintf(fileID,'%s\r\n',data.info.subject_report_choices{3});
    fprintf(fileID,'%s\r\n',data.info.subject_report_choices{4});
    
elseif strcmpi(task,'BGT') % Bangor Gambling Task
    
    fprintf(fileID,'%s\t%s\r\n','Dinero inicial:',num2str(data.info.Start_amount));
    fprintf(fileID,'%s %s\r\n\r\n','Secuencia de ganancias:',data.info.payoff_schedule);
    fprintf(fileID,'%s\t%s\t%s\r\n','Elecc','Dinero','TR (s)');
    fprintf(fileID,'%g\t%g\t%g\r\n',single([data.vars.Gamble_seq data.vars.Money_seq data.vars.RT_seq])');
    
elseif strcmpi(task,'EmoRecoColor') % Emotion Recognition, colors
    fprintf(fileID,'%s\t%s\t%s\r\n','Estimulo','Valencia','Intensidad');
    fprintf(fileID,'%g\t%g\t%g\r\n',([data.vars.Stim_seq data.vars.ValenceResponse_seq(:,1) data.vars.IntensityResponse_seq(:,1)])');

elseif strcmpi(task,'EmoRecoFF') || strcmpi(task,'EmoRecoMusic')  % Emotion Recognition, facial feedback or Music
    fprintf(fileID,'%s\t%s\t%s\t%s\r\n','Bloque','Estimulo','Valencia','Intensidad');
    fprintf(fileID,'%g\t%g\t%g\t%g\r\n',([data.vars.Block_dumm data.vars.Stim_seq data.vars.ValenceResponse_seq(:,1) data.vars.IntensityResponse_seq(:,1)])');
    
elseif strcmpi(task,'WeatherPred') % Weather Prediction Task
    fprintf(fileID,'%s\t%s\t%s\t%s\r\n','Bloque','Estimulo','Desempeno','TR (s)');
    fprintf(fileID,'%g\t%g\t%g\t%g\r\n',([data.vars.Block_dumm data.vars.Stim_seq data.vars.Perform_seq data.vars.RT_seq])');
    fprintf(fileID,'%.50s\r\n', data.info.txtPerf)
    fprintf(fileID,'%s %s\r\n','======', '======');
    fprintf(fileID,'%s\t%s\t%s\r\n','Estimulo','Figuras','Clima');
    for e=1:8
        fprintf(fileID,'%g\t%s\t%s\r\n',e, [data.info.Form_pairs{e,1} '-' data.info.Form_pairs{e,2} '-' data.info.Form_pairs{e,3}],...
            data.info.Weather{e});
    end
    
elseif strcmpi(task,'Ultimatum')
    fprintf(fileID,'%s %s\r\n\r\n','Dinero a repartir:',num2str(data.info.amount2divide));
    
    fprintf(fileID,'%s\t%s\t%s\t%s\t%s\r\n','Bloque','Oferta','Cara','Elecc','TR (s)');
    fprintf(fileID,'%g\t%g\t%g\t%g\t%g\r\n',([data.vars.Block_dumm data.vars.Offer_seq data.vars.Face_seq data.vars.Choice_seq data.vars.RT_seq])');
    
end

fclose(fileID);

BehavData=data; %#ok<NASGU>
save([filename '.mat'],'BehavData')
