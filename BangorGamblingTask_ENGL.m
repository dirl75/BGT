function BangorGamblingTask_ENGL(participantInfo) %#ok<INUSD>
%%

% By Daniel Rojas-Líbano, 
% Universidad Diego Portales (UDP)
% Facultad de Psicología
% Sept 2018



%checkpoint
temp=regexp(pwd,filesep,'split');
if strcmp(temp{end},'BangorGamblingTask_UDP')
else
    error('Change your directory to the ''BangorGamblingTask'' folder')
end

Screen('Preference', 'SkipSyncTests', 1); % skip sync-tests for retina display

settings_BangorGamblingTask_ENGL


[winPointer,winRect] = Screen('OpenWindow', 0);
w = winRect(RectRight);
h = winRect(RectBottom);
flip_interval=Screen('GetFlipInterval',winPointer)/2;

txtTitle='Gambling Task';
txtSpace='PRESS THE SPACE BAR TO CONTINUE';
Screen('TextSize',winPointer, 65);
DrawFormattedText(winPointer,txtTitle,'center','center')
Screen('TextSize',winPointer, 35);
DrawFormattedText(winPointer,txtSpace,'center',0.95*h)
Screen('Flip',winPointer);
KbStrokeWait(deviceIdKey);


for i=1:4 %loop through 4 screens with instructions
    fid = fopen(['instruction_text_BGT_' num2str(i) '_engl.txt'], 'rt');
    instructions_text = '';
    tline = fgets(fid);
    while ischar(tline)
        tline = fgets(fid);
        instructions_text = [instructions_text, tline];
    end
    fclose(fid);
    
    Screen('TextSize',winPointer, 35);
    break_text_at=70;
    DrawFormattedText(winPointer, instructions_text, 0.1*w, 0.14*h, 0, break_text_at);
    
    Screen('TextSize',winPointer, 30);
%     text='PRESIONE LA BARRA DE ESPACIO PARA CONTINUAR';
    DrawFormattedText(winPointer, txtSpace, 'center', 0.952*h, [100;100;100]);
    
    if i==2
        for jj=1
            
            r1=randi([11 13]);
            r2=randi([1 4]);
            suits={'_Spade','_Club','_Heart','_Diamond'};
            Face_card=[num2str(r1) suits{r2}];
            img_face = imread(['.' filesep 'Deck_regular' filesep Face_card '.png']);
            
            r1=randi([1 9]);
            r2=randi([1 4]);
            suits={'_Spade','_Club','_Heart','_Diamond'};
            Pip_card=['0' num2str(r1) suits{r2}];
            img_pip = imread(['.' filesep 'Deck_regular' filesep Pip_card '.png']);
            
            t1 = Screen('MakeTexture', winPointer, img_pip);
            t2 = Screen('MakeTexture', winPointer, img_face);
            %define screen positions for deck
            
            deck_width =round(0.1*w);   %original 144
            deck_height = round(0.3*h);   %original 206
            
            xpos=0.25*w;
            ypos=h/2;
            
            deck_position1 = [xpos, ypos, xpos+deck_width, ypos+deck_height];
            deck_position2 = [xpos+3.3*deck_width, ypos, xpos+4.3*deck_width, ypos+deck_height];
            
            % show decks
            Screen('DrawTexture', winPointer, t1, [], deck_position1);
            Screen('DrawTexture', winPointer, t2, [], deck_position2);
            Screen('TextSize',winPointer, 35);
            DrawFormattedText(winPointer, 'Example:', w/10, h/1.4, [200;200;200], 15);
            DrawFormattedText(winPointer, 'LOSE', w/4, h/2.1, [255;0;0], 85);
            DrawFormattedText(winPointer, 'WIN', w/1.7, h/2.1, [0;190;0], 85);
            
        end
    end
    Screen('Flip',winPointer);
    KbStrokeWait(deviceIdKey);
end

%%
count=0;

Money_seq=nan(n_trials,1);
Gamble_seq=false(n_trials,1);
RT_seq=nan(n_trials,1);
trial_endtime=GetSecs;
for thisTrial=1:n_trials
    
    disp(['trial num ' num2str(thisTrial)])
    trial_exit=false;
    leave=false;
    
    Basic_BGT_Screen(winPointer,winRect,'deck');
    if thisTrial==1
        money_text=['Total: $ ' num2str(Start_amount)];
    end
    Screen('TextSize',winPointer, 30);
    x_pos=0.08*w; y_pos=0.83*h;
    DrawFormattedText(winPointer, money_text, x_pos, y_pos, [50; 50; 50], 185);
    
    trial_start=Screen('Flip',winPointer,trial_endtime+ITI_s-flip_interval);
    
    while trial_exit==false
        [~,~, keyCode] = KbCheck(deviceIdKey);
        
        if keyCode(KbName('O')) %leave task, first confirm choice
            trial_exit=true;
            
            Screen('TextSize',winPointer, 40);
            text='Do you really want to leave the task? (Y o N)';
            DrawFormattedText(winPointer, text, 'center', 'center', [0;0;0], 50);
            Screen('Flip',winPointer)
            dumm=false;
            while dumm==false
                [~,~, keyCode] = KbCheck(deviceIdKey);
                if keyCode(KbName('Y'))
                    dumm=true;
                    leave=true;
                elseif keyCode(KbName('N'))
                    dumm=true;
                    leave=false;
                end
            end
        end
        
        if keyCode(KbName('Y'))
            count=count+1;
            trial_exit=true;
            gamble=true;
            rt=GetSecs-trial_start;
        elseif keyCode(KbName('N'))
            count=count+1;
            trial_exit=true;
            rt=GetSecs-trial_start;
            gamble=false;
        end
        
    end
    
    if leave   %exit task
        Screen('TextSize',winPointer, 60);
        text='Thank you';
        DrawFormattedText(winPointer, text, 'center', 'center', [0; 0; 0], 85);
        Screen('Flip',winPointer)
        WaitSecs(2.5);
        Screen(winPointer,'Close');
        clear screen
        break
    else
        curr_pay=Blocks_pay_sequences(count);
        
        Gamble_seq(thisTrial)=gamble;
        RT_seq(thisTrial)=rt;
        if thisTrial==1
            Money_seq(thisTrial)=Start_amount+curr_pay;
        else
            if gamble==true
                Money_seq(thisTrial)=Money_seq(thisTrial-1)+curr_pay;
            else
                Money_seq(thisTrial)=Money_seq(thisTrial-1);
            end
        end
        if curr_pay<0 && Gamble_seq(thisTrial)==true
            feedback_text='LOSE!!';
            text_color=[255; 0; 0];
            sign='';
        elseif curr_pay>0 && Gamble_seq(thisTrial)==true
            feedback_text='WIN!!';
            text_color=[0; 190; 0];
            sign='+';
        end
        
        if Gamble_seq(thisTrial)==true
            payoff_text=[sign num2str(curr_pay)];
        else
            feedback_text='NOTHING';
            text_color=[150;150;150];
            sign='';
            payoff_text='0';
        end
        
        Basic_BGT_Screen(winPointer,winRect,Blocks_card_sequences{count}); %#ok<USENS>
        DrawFormattedText(winPointer, feedback_text, 'center', h/1.5, text_color, 85);
        DrawFormattedText(winPointer, payoff_text, 'center', h/1.2, text_color, 85);
        
        money_text=['Total: $ ' num2str(Money_seq(thisTrial))];
        Screen('TextSize',winPointer, 30);
        x_pos=0.08*w; y_pos=0.83*h;
        DrawFormattedText(winPointer, money_text, x_pos, y_pos, [50; 50; 50], 185);
        
        trial_endtime=Screen('Flip',winPointer);
        
        data.vars.Gamble_seq=Gamble_seq;
        data.vars.Money_seq=Money_seq;
        data.vars.RT_seq=RT_seq;
        
        if thisTrial==round(0.25*n_trials) || thisTrial==round(0.5*n_trials) || thisTrial==round(0.75*n_trials)
            saveBehavData('BGT',data)
        end
        
        %if last trial, display goodbye screen
        if thisTrial==n_trials
            WaitSecs(1.5);
            text_goodbye='Thank You';
            Screen('TextSize',winPointer, 90);
            DrawFormattedText(winPointer, text_goodbye, 'center', 'center', [50; 50; 50], 185);
            Screen('Flip',winPointer);
            WaitSecs(3);
        end
    end
end

if leave
else
    saveBehavData('BGT',data)
    sca
end


