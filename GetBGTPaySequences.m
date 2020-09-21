function [Blocks_pay_sequences, Blocks_card_sequences]=GetBGTPaySequences(payoff_schedule)

% By Daniel Rojas-Líbano, 
% Universidad Diego Portales (UDP)
% Facultad de Psicología
% Sept 2018


%Sequences are taken from Bowman & Turnbull, 2004
%
%Each block consists of 20 trials
Card_Seq_Block1={'11_Spade','11_Club','12_Spade','06_Club','12_Diamond',...
    '02_Diamond','11_Heart','12_Diamond', '12_Club', '11_Diamond',...
    '09_Heart', '01_Heart', '11_Spade', '12_Heart', '07_Spade',...
    '13_Club', '11_Diamond', '04_Club', '12_Spade', '12_Heart' };

Card_Seq_Block2={'08_Club', '01_Spade', '11_Heart', '06_Diamond', '03_Diamond',...
    '09_Club', '11_Club', '10_Spade', '12_Diamond', '12_Club',...
    '11_Diamond', '07_Heart', '07_Club', '12_Heart', '11_Spade',...
    '06_Spade', '01_Diamond', '10_Heart', '05_Spade', '11_Heart'};

Card_Seq_Block3={'06_Diamond', '08_Heart', '09_Spade', '11_Club', '08_Club',...
    '11_Heart', '10_Diamond', '04_Heart', '06_Spade', '12_Club',...
    '09_Diamond', '06_Club', '08_Diamond', '07_Club', '13_Spade',...
    '06_Heart', '08_Spade', '01_Heart', '10_Spade', '09_Diamond'};

Card_Seq_Block4={'03_Club', '06_Diamond', '02_Heart', '12_Spade', '04_Club',...
    '03_Spade', '05_Heart', '06_Club', '11_Spade', '13_Diamond',...
    '05_Club', '03_Diamond', '06_Spade', '07_Diamond', '13_Heart',...
    '02_Diamond', '04_Heart', '01_Club', '06_Heart', '05_Spade'};

Card_Seq_Block5={'02_Heart', '03_Spade', '05_Spade', '12_Club', '03_Heart',...
    '06_Heart', '02_Spade', '04_Diamond', '10_Club', '05_Heart',...
    '04_Spade', '05_Diamond', '02_Club', '11_Club', '02_Heart',...
    '06_Spade', '04_Diamond', '03_Club', '12_Diamond', '06_Diamond'};

Pay_Seq_Block1=[10 10 10 -10 10 -20 10 10 10 10 ...
    -10 20 10 10 -10 20 10 -20 10 10];
Pay_Seq_Block2=[-10 20 10 -10 -20 -10 10 -10 10 10 ...
    10 -10 -10 10 10 -10 20 -10 -20 10];
Pay_Seq_Block3=[-10 -10 -10 10 -10 10 -10 -20 -10 10 ...
    -10 -20 -10 -10 20 -10 -10 20 -10 -10];
Pay_Seq_Block4=[-20 -20 -20 10 -20 -20 -20 -20 10 20 ...
    -20 -20 -20 -10 20 -20 -20 20 -10 -20];
Pay_Seq_Block5=[-20 -20 -20 10 -20 -20 -20 -20 -10 -20 ...
    -20 -20 -20 10 -20 -20 -20 -20 10 -20];

if strcmpi(payoff_schedule, 'Bowman_Exact')
    %do nothing. keep sequences as they are.
elseif strcmpi(payoff_schedule, 'Bowman_Probability')
    
    % randomize sequences within each 20-trial block
    
    rnd=randperm(numel(Card_Seq_Block1));
    Card_Seq_Block1=Card_Seq_Block1(rnd);
    Pay_Seq_Block1=Pay_Seq_Block1(rnd);
    rnd=randperm(numel(Card_Seq_Block2));
    Card_Seq_Block2=Card_Seq_Block2(rnd);
    Pay_Seq_Block2=Pay_Seq_Block2(rnd);
    rnd=randperm(numel(Card_Seq_Block3));
    Card_Seq_Block3=Card_Seq_Block3(rnd);
    Pay_Seq_Block3=Pay_Seq_Block3(rnd);
    rnd=randperm(numel(Card_Seq_Block4));
    Card_Seq_Block4=Card_Seq_Block4(rnd);
    Pay_Seq_Block4=Pay_Seq_Block4(rnd);
    rnd=randperm(numel(Card_Seq_Block5));
    Card_Seq_Block5=Card_Seq_Block5(rnd);
    Pay_Seq_Block5=Pay_Seq_Block5(rnd);
    
    
end
%%
Blocks_card_sequences=[Card_Seq_Block1 Card_Seq_Block2 Card_Seq_Block3...
    Card_Seq_Block4 Card_Seq_Block5];
Blocks_pay_sequences=[Pay_Seq_Block1 Pay_Seq_Block2 Pay_Seq_Block3...
    Pay_Seq_Block4 Pay_Seq_Block5];