%{

New Carousel Protocol

By: Leonardo Jared Ramirez Sanchez, CSHL

Last modified: 05/2/2019 4:58 PM
 
Added: SoftCodeHandlerFunction to control Bonsai events 
%}


function CarouselTask

global BpodSystem  S nidaq



%% Define parameters
S = BpodSystem.ProtocolSettings; % Load settings chosen in launch manager into current workspace as a struct called S
if isempty(fieldnames(S))  % If settings file was an empty struct, populate struct with default settings
    % Next Parameters will be DefaultSettings
    S.GUI.RewardAmount = 4; %4 ul as original Csys protocol.
    S.GUI.RewardValve = 1; %You can add more valves
    S.GUI.Photometry=0;
    S.GUIMeta.Photometry.Style = 'checkbox';%Default needs no photometry
    S.GUI.CsystemOn=0; %Default needs no Csystem Working
    S.GUIMeta.CsystemOn.Style = 'checkbox';
    S.GUI.variableRewards = 0;
    S.GUIMeta.variableRewards.Style = 'checkbox';
    S.GUI.PulsePadOn=0; %Default needs no PulsePad
    S.GUIMeta.PulsePadOn.Style = 'checkbox';
    S.GUI.SocialClueSpecificReward=0; %We will use field RewardAmount as a global Reward
    S.GUIMeta.SocialClueSpecificReward.Style = 'checkbox';
    S.GUI.DbleFibers = 0;
    S.GUIMeta.DbleFibers.Style = 'checkbox';
    S.GUI.LivePlots=0; %For plot Dwell Time vs Trial number and social preferences plot
    S.GUIMeta.LivePlots.Style = 'checkbox';
    S.GUI.MaxTrials=1500;
end

%General
S.Names.StateToZero={'RewardTrig','CenterReward','Drinking','ContinueSampling','WaitForInitialPoke','WaitForSocialGate'};
S.Names.Cue={'Social'};

%Task Parameters- Timing ADD 05/06/2019 by Leo
S.GUI.PreOpenBlackDoor=1.5;
S.GUI.Delay=0;
S.GUI.PostOutcome=5;
S.GUI.preITI=2;
S.GUIPanels.TaskTiming={'PreOpenBlackDoor','Delay','PostOutcome','preITI'};

S.GUI.StateToZero=2;
S.GUI.StateToZero2=4;
S.GUIMeta.StateToZero.Style='popupmenu';
S.GUIMeta.StateToZero.String=S.Names.StateToZero;
S.GUIMeta.StateToZero2.Style='popupmenu';
S.GUIMeta.StateToZero2.String=S.Names.StateToZero;
S.GUI.BaselineBegin=0.2; %original 1.5
S.GUI.BaselineEnd=1.5;  %original 2.5
S.GUIPanels.PlotTiming={'StateToZero','StateToZero2','BaselineBegin','BaselineEnd'};
S.GUITabs.Timing={'TaskTiming','PlotTiming'};



S.GUI.CueType=1;
S.GUIMeta.CueType.Style='popupmenu';
S.GUIMeta.CueType.String=S.Names.Cue;
S.GUI.NbOfFreq=1;
S.GUI.FreqWidth=1;
S.GUIPanels.Cue={'CueType','NbOfFreq','FreqWidth'};
S.GUITabs.Cue={'Cue'};

%Task Parameters
S.GUIMeta.Photometry.Style = 'checkbox';%Default needs no photometry
S.GUIMeta.CsystemOn.Style = 'checkbox';
S.GUIMeta.PulsePadOn.Style = 'checkbox';
S.GUIMeta.SocialClueSpecificReward.Style = 'checkbox';
S.GUIMeta.variableRewards.Style = 'checkbox';
S.GUIMeta.DbleFibers.Style = 'checkbox';
S.GUIMeta.LivePlots.Style = 'checkbox';
S.GUI.Isobestic405=0;
S.GUIMeta.Isobestic405.Style='checkbox';
S.GUIMeta.Isobestic405.String='Auto';
S.GUI.RedChannel=0;
S.GUIMeta.RedChannel.Style='checkbox';
S.GUIMeta.RedChannel.String='Auto'; 
S.GUIPanels.Recording={'CsystemOn','variableRewards','Photometry','DbleFibers','Isobestic405','RedChannel','PulsePadOn','LivePlots','SocialClueSpecificReward','MaxTrials'};%%'variableRewards'
S.GUIPanels.Reward={'RewardAmount','RewardValve'}; %%'RewardAmountSocialClue1','RewardAmountSocialClue2','RewardAmountSocialClue3','RewardAmountSocialClue4','RewardAmountSocialClue5','RewardAmountSocialClue6','RewardAmountSocialClue7','RewardAmountSocialClue8','RewardAmountSocialClue9','RewardAmountSocialClue10','RewardAmountSocialClue11','RewardAmountSocialClue8'%
%%commented out all the rewardamountsocialclue stuff because I don't want
%%to have reward values different across object animals as 6/3/2020

%Plot
S.GUI.MultiplePlots = 1;
S.GUIMeta.MultiplePlots.Style='checkbox';
S.GUI.TimeMin=-3.5; %original -4
S.GUI.TimeMax=3.5; %original 4
S.GUI.NidaqMin=-3.5; %original  -5
S.GUI.NidaqMax=8.5; %original 10
S.GUIPanels.Plot={'TimeMin','TimeMax','NidaqMin','NidaqMax','MultiplePlots'};

S.GUITabs.General={'Plot','Recording','Reward'};

%Photometry
S.GUI.PhotometryVersion=1;
S.GUI.nidaqDev = 'CarouselPhoto';
S.GUI.Modulation=1;
S.GUIMeta.Modulation.Style='checkbox';
S.GUIMeta.Modulation.String='Auto';
S.GUI.NidaqDuration=150;
S.GUI.NidaqSamplingRate=6100;
S.GUI.DecimateFactor=610;
S.GUI.LED1_Name='Fiber1 470-A1';
S.GUI.LED1_Amp=4.5;
S.GUI.LED1_Freq=211;
S.GUI.LED2_Name='Fiber1 405 / 565';
S.GUI.LED2_Amp=9.8;
S.GUI.LED2_Freq=531;
S.GUI.LED1b_Name='Fiber2 470-mPFC';
S.GUI.LED1b_Amp=1; %Ignore this, isn't neccesary
S.GUI.LED1b_Freq=531;

S.GUIPanels.Photometry={'nidaqDev','PhotometryVersion','Modulation','NidaqDuration',...
                        'NidaqSamplingRate','DecimateFactor',...
                        'LED1_Name','LED1_Amp','LED1_Freq',...
                        'LED2_Name','LED2_Amp','LED2_Freq',...
                        'LED1b_Name','LED1b_Amp','LED1b_Freq'};

S.GUITabs.Photometry={'Photometry'};

%% Intilitilaze 

% Initialize parameter GUI plugin and Pause

BpodParameterGUI('init', S);

BpodSystem.Pause=1;
HandlePauseCondition;

%Parameters Extraction for easy code reading
S = BpodParameterGUI('sync', S); %Synchronize parameters from GUI 
Photometry = S.GUI.Photometry;
CsystemOn = S.GUI.CsystemOn;
variableRewards = S.GUI.variableRewards;
disp(CsystemOn)
PulsePad = S.GUI.PulsePadOn;
SocialClueSpecificReward = S.GUI.SocialClueSpecificReward;
LivePlots = S.GUI.LivePlots;


%  Initialize Csystem and PulsePad 

try
    if CsystemOn
        evalin('base', 'Csystem;');
        disp('Csystem open detected proceeding to close it in order to avoid problems');
        evalin('base', 'EndCsystem');
    else
        disp('Training Leve1 1: Csystem will not use');
        disp('Changos');
    end
catch
    disp('Csystem is not open, procceding to initialize');
end



if CsystemOn
    evalin('base', 'StartCystem2');
    %StartCystem2;
elseif PulsePad    
    evalin('base', 'PulsePal');
end
pause(.1);





%% Define trial types parameters, trial sequence 

% Trial Sequence (with or without blocks) which will be define by the
% animals you are presenting : 1 4 5 3 2 1 
% TrialSequence of size S.GUI.MaxTrials
nBlocks=1; 
nTrialTypes(nBlocks)= 8; %Changed from 8 to 8 since #animals I have changedAAS 6/11/20. Because we only have 8 space in carousel
MaximumTravelDistance = 4; %Max number of carousel mice to skip
BlockLength =  S.GUI.MaxTrials; %Originally 5000 in previous BpodProtocol
% Proccess to generate random trials for carousel Task
for x = 1:nBlocks % x -> number of blocks, for carousel we only have 1 block, but this could be useful in the future....
    TT = zeros(1,BlockLength);
    TT(1) = ceil(rand*8);
    for y = 2:BlockLength
        UniqueTrialTypes = nTrialTypes(x);
        Validated = 0;
        while Validated == 0
            CandidateValue = ceil(rand*UniqueTrialTypes);
            OriginalCandidate = CandidateValue;
            PreviousValue = TT(y-1);
            Diff = abs(CandidateValue-PreviousValue);
            if Diff > 6
                if CandidateValue > PreviousValue
                    PreviousValue = PreviousValue + 8;
                else
                    CandidateValue = CandidateValue + 8;
                end
                Diff = abs(CandidateValue-PreviousValue);
            end
            if Diff <= MaximumTravelDistance && (CandidateValue ~= PreviousValue)
                Validated = 1;
                NewValue = OriginalCandidate;
            end
        end
        TT(y) = NewValue;
    end
    
    if x>1
        TrialTypes{x} = TT;
    else
        TrialTypes=TT;
    end
end
BpodSystem.Data.TrialTypes = []; % The trial type of each trial completed will be added here.


if variableRewards
%     K = RandStream('mlfg6331_64'); USE if you want to utilize a seed, so
%     that you can accces the exact same generate ranom number set. I want
%     it all new all the time so yeah
    rewardValues = randsample([8,12,16],S.GUI.MaxTrials,true,[1/3 1/3 1/3]);
else
    disp('Reward values are not shuffled in this session');
end



% 	shuffledReward = randsample([4,8,8],S.MaxTrials,true,[1/3 1/3 1/3]);
% 	rewardValues = shuffledReward(CurrentTrial)


%%commented out the below in order to sanity check myself, AAS 6/2/2020
%%trying to code three randomly variable reward amounts

selectSpecificReward=0;
if ~SocialClueSpecificReward 
    R = GetValveTimes(S.GUI.RewardAmount, S.GUI.RewardValve); %remeber you can choose up to 8 valves and each should have been calibrated
    UniqueValveTime = R(1);  % Update reward amounts just for one valve
    S.Reward=UniqueValveTime;
else
    selectSpecificReward=1;
    R = GetValveTimes(S.GUI.RewardAmount, S.GUI.RewardValve); %remeber you can choose up to 8 valves and each should have been calibrated
    UniqueValveTime = R(1);  % Update reward amounts just for one valve
    S.Reward=UniqueValveTime;
end
    

%% Initialize plots

BpodSystem.ProtocolFigures.OutcomePlotFig = figure('Position', [200 200 1000 200],'name','Outcome plot','numbertitle','off', 'MenuBar', 'none', 'Resize', 'off');
BpodSystem.GUIHandles.OutcomePlot = axes('Position', [.075 .3 .89 .6]);


%In order to revert to a more simplistic and minimalist version delete the
%following codes (until TrialTypesOutcomePlot).


BpodSystem.ProtocolFigures.OutcomePlotFig = figure('Position', [425 200 1100 590],'name','Outcome plot','numbertitle','off', 'MenuBar', 'none', 'Resize', 'off');
ha = axes('units','normalized', 'position',[0 0 1 1]);
uistack(ha,'bottom');
BG = imread('LiveSessionDataBGV05.bmp');
image(BG); axis off;
BpodSystem.GUIHandles.OutcomePlot = axes('position',[.07  .75  .9  .15], 'TickDir', 'out', 'YColor', [1 1 1], 'XColor', [1 1 1]);
BpodSystem.GUIHandles.ProtocolNameDisplay = uicontrol('Style', 'text', 'String', [BpodSystem.CurrentProtocolName], 'Position', [170 67 175 18], 'FontWeight', 'bold', 'FontSize', 10, 'ForegroundColor', [1 1 1], 'BackgroundColor', [.45 .45 .45]);
BpodSystem.GUIHandles.SubjectNameDisplay = uicontrol('Style', 'text', 'String', [BpodSystem.GUIData.SubjectName], 'Position', [170 40 175 18], 'FontWeight', 'bold', 'FontSize', 10, 'ForegroundColor', [1 1 1], 'BackgroundColor', [.45 .45 .45]);
BpodSystem.GUIHandles.TrialNumberDisplay = uicontrol('Style', 'text', 'String', '1', 'Position', [520 67 105 18], 'FontWeight', 'bold', 'FontSize', 10, 'ForegroundColor', [1 1 1], 'BackgroundColor', [.44 .44 .44]);
BpodSystem.GUIHandles.TrialTypeDisplay = uicontrol('Style', 'text', 'String', '1', 'Position', [520 40 105 18], 'FontWeight', 'bold', 'FontSize', 10, 'ForegroundColor', [1 1 1], 'BackgroundColor', [.44 .44 .44]);
BpodSystem.GUIHandles.BlockNumberDisplay = uicontrol('Style', 'text', 'String', '1', 'Position', [520 13 105 18], 'FontWeight', 'bold', 'FontSize', 10, 'ForegroundColor', [1 1 1], 'BackgroundColor', [.44 .44 .44]);
BpodSystem.GUIHandles.SettingsFileDisplay = uicontrol('Style', 'text', 'String',[BpodSystem.GUIData.SettingsFileName], 'Position', [170 13 175 18], 'FontWeight', 'bold', 'FontSize', 10, 'ForegroundColor', [1 1 1], 'BackgroundColor', [.45 .45 .45]);
TrialTypeOutcomePlot(BpodSystem.GUIHandles.OutcomePlot,'init',TrialTypes./TrialTypes); %TrialTypeOutcomePlot(BpodSystem.GUIHandles.OutcomePlot,'init',TrialTypes);
set(BpodSystem.GUIHandles.OutcomePlot,'YTickLabel', {'Other', 'Other', 'Right'}, 'FontSize', 11);

if LivePlots
    BpodSystem.GUIHandles.LivePlot2 = axes('position',[.56  .23  .42  .375], 'TickDir', 'out', 'YColor', [1 1 1], 'XColor', [1 1 1]);
    BpodSystem.GUIHandles.LivePlot1 = axes('position',[.07  .23  .42  .375], 'TickDir', 'out', 'YColor', [1 1 1], 'XColor', [1 1 1]);
end

BpodNotebook('init');
TotalRewardDisplay('init');


% Initialize Photometry
if Photometry
    Nidaq_photometry('ini'); 
end

%More plots photometry
if LivePlots && Photometry
    [S.TrialsNames, S.TrialsMatrix] = carouselTaskTrialPhase(S,'simpleCarousel');
    FigNidaq1 = Online_NidaqPlot('ini','470');
        if S.GUI.DbleFibers || S.GUI.Isobestic405 || S.GUI.RedChannel
            FigNidaq2=Online_NidaqPlot('ini','channel2');
        end
if S.GUI.MultiplePlots
            FigNidaq3 = Online_NidaqPlot('ini','470_SocialPlataform');
end

%%end

%% SoftCodeHandlerFunction for Bonsai and UDP communication
% BpodSystem.BonsaiSocket.UDP = udp('87.0.0.1',1836);
BpodSystem.BonsaiSocket.UDP = udp('127.0.0.1',11236);
fopen(BpodSystem.BonsaiSocket.UDP);
BpodSystem.SoftCodeHandlerFunction = 'SoftCodeHandler_Bonsai';

%% Main trial loop
CloseBlackDoor; %Use this function once test is finish
for currentTrial = 1:S.GUI.MaxTrials
    
    S = BpodParameterGUI('sync', S);
    

    
    nStartedTrials = currentTrial; %this could be redundant, and in fact it is, but the objective is establishment a coherence in variables between Csyste protocol and CarousselTask protocol
    
    %Present the mouse --> Ask arduino to control the
    %industrialMicrocontroller
    %Select Mouse according to the Trial open and close door.
 
    if variableRewards
        %shuffledReward = rewardValues(currentTrial); 
        shuffledReward = GetValveTimes(rewardValues(currentTrial),S.GUI.RewardValve);
        disp(rewardValues(currentTrial));
    end
   
   

    if CsystemOn
        CsystemGate(0);
        if nBlocks >1 %In case we have blocks (uncommun) 
            SelectMouse2(TrialTypes{CurrentBlock}(nStartedTrials));
        else
            SelectMouse2(TrialTypes(nStartedTrials));
        end
        pause(1.1)
        CsystemGate(1);
    end
    
    
 
    
    % Assemble State matrix
 	sma = NewStateMatrix();
    
    
    %Pre task states
    %%%% Asamble  State Matrix Using Redundant States found in the first
    %%%% carousel protocol version (Bpod Alpha)
% %     if selectSpecificReward
% %         switch TrialTypes(currentTrial) % Determine trial-specific state matrix fields
% %             case 1
% %                 %in case you need modify something specifically in this trial
% %                 %type
% %                 R = GetValveTimes(S.GUI.RewardAmountSocialClue1, S.GUI.RewardValve); %remeber you can choose up to 8 valves and each should have been calibrated
% %                 UniqueValveTime = R(1);
% %                 S.Reward=UniqueValveTime;
% %             case 2
% %                 %in case you need modify something specifically in this trial
% %                 %type
% %                 R = GetValveTimes(S.GUI.RewardAmountSocialClue2, S.GUI.RewardValve); %remeber you can choose up to 8 valves and each should have been calibrated
% %                 UniqueValveTime = R(1);
% %                 S.Reward=UniqueValveTime;
% %             case 3
% %                 %in case you need modify something specifically in this trial
% %                 %type
% %                 R = GetValveTimes(S.GUI.RewardAmountSocialClue3, S.GUI.RewardValve); %remeber you can choose up to 8 valves and each should have been calibrated
% %                 UniqueValveTime = R(1);
% %                 S.Reward=UniqueValveTime;
% %             case 4
% %                 %in case you need modify something specifically in this trial
% %                 %type
% %                 R = GetValveTimes(S.GUI.RewardAmountSocialClue4, S.GUI.RewardValve); %remeber you can choose up to 8 valves and each should have been calibrated
% %                 UniqueValveTime = R(1);
% %                 S.Reward=UniqueValveTime;
% %             case 5           
% %                 %in case you need modify something specifically in this trial
% %                 %type
% %                 R = GetValveTimes(S.GUI.RewardAmountSocialClue5, S.GUI.RewardValve); %remeber you can choose up to 8 valves and each should have been calibrated
% %                 UniqueValveTime = R(1);
% %                 S.Reward=UniqueValveTime;
% %             case 6
% %                 %in case you need modify something specifically in this trial
% %                 %type
% %                 R = GetValveTimes(S.GUI.RewardAmountSocialClue6, S.GUI.RewardValve); %remeber you can choose up to 8 valves and each should have been calibrated
% %                 UniqueValveTime = R(1);
% %                 S.Reward=UniqueValveTime;
% %             case 7
% %                 %in case you need modify something specifically in this trial
% %                 %type
% %                 R = GetValveTimes(S.GUI.RewardAmountSocialClue7, S.GUI.RewardValve); %remeber you can choose up to 8 valves and each should have been calibrated
% %                 UniqueValveTime = R(1);
% %                 S.Reward=UniqueValveTime;
% %             case 8
% %                 %in case you need modify something specifically in this trial
% %                 %type
% %                 R = GetValveTimes(S.GUI.RewardAmountSocialClue8, S.GUI.RewardValve); %remeber you can choose up to 8 valves and each should have been calibrated
% %                 UniqueValveTime = R(1);
% %                 S.Reward=UniqueValveTime;
% %             case 9 
% %                 %in case you need modify something specifically in this trial
% %                 %type
% %                 R = GetValveTimes(S.GUI.RewardAmountSocialClue9, S.GUI.RewardValve); %remeber you can choose up to 8 valves and each should have been calibrated
% %                 UniqueValveTime = R(1);
% %                 S.Reward=UniqueValveTime;
% %             case 10
% %                 %in case you need modify something specifically in this trial
% %                 %type
% %                 R = GetValveTimes(S.GUI.RewardAmountSocialClue10, S.GUI.RewardValve); %remeber you can choose up to 8 valves and each should have been calibrated
% %                 UniqueValveTime = R(1);
% %                 S.Reward=UniqueValveTime;
% %             case 11
% %                 %in case you need modify something specifically in this trial
% %                 %type
% %                 R = GetValveTimes(S.GUI.RewardAmountSocialClue11, S.GUI.RewardValve); %remeber you can choose up to 8 valves and each should have been calibrated
% %                 UniqueValveTime = R(1);
% %                 S.Reward=UniqueValveTime;
% %             case 8
% %                 %in case you need modify something specifically in this trial
% %                 %type
% %                 R = GetValveTimes(S.GUI.RewardAmountSocialClue8, S.GUI.RewardValve); %remeber you can choose up to 8 valves and each should have been calibrated
% %                 UniqueValveTime = R(1);
% %                 S.Reward=UniqueValveTime;
% %         end
% %     end

    
    sma = AddState(sma, 'Name', 'InitialDelay',...
				'Timer',S.GUI.PreOpenBlackDoor,... %0.050,... %Wait 50 mili seconds to send command to arduino and open black door
				'StateChangeConditions',{'Tup','WaitForInitialPoke'},...
				'OutputActions',{'SoftCode',TrialTypes(nStartedTrials)}); %open black door

    sma = AddState(sma, 'Name','WaitForInitialPoke',...
				'Timer',0,...
				'StateChangeConditions',{'Port3In','LaserOn'},... %'Port2In','LaserOn', I deleted this one
				'OutputActions',{'WireState', 1}); %In case door didn't open in previous state

    sma = AddState(sma,'Name','LaserOn',...
			'Timer',0.1,...
			'StateChangeConditions',{'Tup','WaitForSocialGate'},...
			'OutputActions',{'WireState', 1});

    sma = AddState(sma,'Name','WaitForSocialGate',...
			'Timer',0,...
			'StateChangeConditions',{'Port2In','StimulusDelay1'},...
			'OutputActions',{});

    sma = AddState(sma,'Name','StimulusDelay1',...
			'Timer',0,...
			'StateChangeConditions',{'Port3In','DeliveryStimulus1','Tup','DeliveryStimulus1','Port3Out','WaitForInitialPoke'},...
			'OutputActions',{});

    sma = AddState(sma,'Name','DeliveryStimulus1',...
			'Timer',0,...
			'StateChangeConditions',{'Port1Out','iti','Tup','ContinueSampling'},...
			'OutputActions',{});

    sma = AddState(sma,'Name','preiti',... %New State
			'Timer',S.GUI.preITI,... 
			'StateChangeConditions',{'Tup','iti'},...
			'OutputActions',{'WireState', 2}); %close black door

    sma = AddState(sma,'Name','iti',...
			'Timer',0,... 
			'StateChangeConditions',{'Tup','exit'},...
			'OutputActions',{'WireState', 2}); %close black door
        
    sma = AddState(sma,'Name','ContinueSampling',...
			'Timer',0.2,... %200 miliseconds
			'StateChangeConditions',{'Port1Out','WaitforResponse','Tup','WaitforResponse'},...
			'OutputActions',{});

    sma = AddState(sma,'Name','WaitforResponse',...
			'Timer',300,... %taken from original Bpod alpha version
			'StateChangeConditions',{'Port1In','RewardTrig','Port3In','L2Passed','Tup','iti'},...*Changed to port 3 instead of 5. three is now by black door
			'OutputActions',{});

    sma = AddState(sma,'Name','RewardTrig',...
			'Timer',0.050,... %50 ms delay so TTL is read
			'StateChangeConditions',{'Tup','CenterReward'},...
			'OutputActions',{'WireState', 2}); %black door closed
			
    sma = AddState(sma,'Name','BlackDoorPassed',...
			'Timer',400,... %taken from original Bpod alpha version  Port5In was for other sensor I changed to Port3In just to make the test
			'StateChangeConditions',{'Port3In','L2Passed','Tup','iti'},... *
			'OutputActions',{});

    sma = AddState(sma,'Name','L2Passed',...
			'Timer',400,... %taken from original Bpod Alpha version
			'StateChangeConditions',{'Port1In','RewardTrig','Tup','iti'},...
			'OutputActions',{});
			
    sma = AddState(sma,'Name','CenterReward',...
			'Timer',shuffledReward,...
			'StateChangeConditions',{'Tup','Drinking'},...
			'OutputActions',{'Valve',1});

    sma = AddState(sma,'Name','Drinking',...
			'Timer',0.500,... %taken from variable "DriknIdleTimer" from Bpod alpha version
			'StateChangeConditions',{'Port1In','ResetDrinkTimer','Tup','preiti'},...
			'OutputActions',{});

    sma = AddState(sma,'Name','ResetDrinkTimer',...
			'Timer',0,...
			'StateChangeConditions',{'Tup','Drinking'},...
			'OutputActions',{});

    SendStateMatrix(sma);
    
    
    TotalRewardDisplay('add', rewardValues(currentTrial));

    %Intialize photometry 
    if Photometry
        Nidaq_photometry('WaitToStart');  %Start photometry data when trial Start//Quentin will provide Nidaq_Photometry function...
    end
    
    
    oscsend(BpodSystem.BonsaiSocket.UDP,'/receiver','i', 13); %Start video Recording
    oscsend(BpodSystem.BonsaiSocket.UDP,'/transition','s', 'TRIAL'); %label frames as part of trial
    
    
    RawEvents = RunStateMatrix; %Run State Matrix/Start Trial
    
    
    oscsend(BpodSystem.BonsaiSocket.UDP,'/transition','s', 'ITI');
    if Photometry
        Nidaq_photometry('Stop');
        [PhotoData,~,Photo2Data]=Nidaq_photometry('Save'); %Stop photometry data adcquisition after trial ends
        if Photometry
            BpodSystem.Data.NidaqData{currentTrial} = PhotoData;
            if S.GUI.DbleFibers || S.GUI.RedChannel
                BpodSystem.Data.Nidaq2Data{currentTrial}=Photo2Data;
            end
        end
    end
    
    
    % Save the whole data
    if ~isempty(fieldnames(RawEvents))                                          % If trial data was returned
        BpodSystem.Data = AddTrialEvents(BpodSystem.Data,RawEvents);            % Computes trial events from raw data
        BpodSystem.Data.TrialSettings(currentTrial) = S;                        % Adds the settings used for the current trial to the Data struct (to be saved after the trial ends)
        BpodSystem.Data.TrialTypes(currentTrial) = TrialTypes(currentTrial);    % Adds the trial type of the current trial to data
        BpodSystem.Data.rewardValues(currentTrial) = rewardValues(currentTrial);
        BpodSystem.Data = BpodNotebook('sync', BpodSystem.Data);
        
    % Add dwell time based on beam 1 to the data file
    if ~isfield(BpodSystem.Data, 'Dwelltime')
        BpodSystem.Data.Dwelltime = [];
    end
    DataSize = length(BpodSystem.Data.RawEvents.Trial); % This condition was added to prevent a gui closing event from trying to execute this on an incomplete trial
        if DataSize == nStartedTrials
            if isfield(BpodSystem.Data.RawEvents.Trial{nStartedTrials}.Events, 'Port3In') % In Csys.m this line reads as: 'if isfield(TE.RawEvents.Trial{nStartedTrials}.Events, 'Rin')'
                Beam1Breaktimes = BpodSystem.Data.RawEvents.Trial{nStartedTrials}.Events.Port3In;
                if ~isempty(Beam1Breaktimes)
                    BpodSystem.Data.Dwelltime(nStartedTrials) = Beam1Breaktimes(end)-Beam1Breaktimes(1);
                else
                    BpodSystem.Data.Dwelltime(nStartedTrials) = NaN;
                    %disp(['Dwell time not registered for trial ' num2str(nStartedTrials)])
                end
            else
                BpodSystem.Data.Dwelltime(nStartedTrials) = NaN;
                %disp(['Dwell time not registered for trial ' num2str(nStartedTrials)])
            end
        end
    UpdateOutcomePlot(TrialTypes, BpodSystem.Data, LivePlots);
    SaveBpodSessionData; % Saves the field BpodSystem.Data to the current data file
    end
    
    %Plot Photometry online
    
    if Photometry
        try
        [currentNidaq1, rawNidaq1]=Online_NidaqDemod(PhotoData(:,1),nidaq.LED1,S.GUI.LED1_Freq,S.GUI.LED1_Amp,S.Names.StateToZero{S.GUI.StateToZero});
        FigNidaq1=Online_NidaqPlot('update',[],FigNidaq1,currentNidaq1,rawNidaq1);

        if S.GUI.Isobestic405 || S.GUI.DbleFibers || S.GUI.RedChannel
            if S.GUI.Isobestic405
            [currentNidaq2, rawNidaq2]=Online_NidaqDemod(PhotoData(:,1),nidaq.LED2,S.GUI.LED2_Freq,S.GUI.LED2_Amp,S.Names.StateToZero{S.GUI.StateToZero});
            elseif S.GUI.RedChannel
            [currentNidaq2, rawNidaq2]=Online_NidaqDemod(Photo2Data(:,1),nidaq.LED2,S.GUI.LED2_Freq,S.GUI.LED2_Amp,S.Names.StateToZero{S.GUI.StateToZero});
            elseif S.GUI.DbleFibers
            [currentNidaq2, rawNidaq2]=Online_NidaqDemod(Photo2Data(:,1),nidaq.LED2,S.GUI.LED1b_Freq,S.GUI.LED1b_Amp,S.Names.StateToZero{S.GUI.StateToZero});
            end
            FigNidaq2=Online_NidaqPlot('update',[],FigNidaq2,currentNidaq2,rawNidaq2);
        end
        if S.GUI.MultiplePlots
            [currentNidaq3, rawNidaq3]=Online_NidaqDemod(PhotoData(:,1),nidaq.LED1,S.GUI.LED1_Freq,S.GUI.LED1_Amp,S.Names.StateToZero{S.GUI.StateToZero2});
            FigNidaq3=Online_NidaqPlot('update',[],FigNidaq3,currentNidaq3,rawNidaq3);
        end
        catch
            disp('Oups something went wrong with the photometry plotting')
        end
    end
    
    %More photometry examination 
    
    %% Photometry QC taken from Quentin 
    if currentTrial==1 && S.GUI.Photometry
        thismax=max(PhotoData(S.GUI.NidaqSamplingRate:S.GUI.NidaqSamplingRate*2,1));
        if thismax>4 || thismax<0.3
            disp('WARNING - Something is wrong with fiber #1 - run check-up! - unpause to ignore')
            BpodSystem.Pause=1;
            HandlePauseCondition;
        end
        %%commented out Dble fibers error bc I am not using the red
        %%channel, AS 6/3/2020
% %         if S.GUI.DbleFibers || S.GUI.RedChannel
% %         thismax=max(Photo2Data(S.GUI.NidaqSamplingRate:S.GUI.NidaqSamplingRate*2,1));
% %         if thismax>4 || thismax<0.3
% %             disp('WARNING - Something is wrong with fiber #2 - run check-up! - unpause to ignore')
% %             BpodSystem.Pause=1;
% %             HandlePauseCondition;
% %         end
% %         end
    end

    
    
    
    HandlePauseCondition; % Checks to see if the protocol is paused. If so, waits until user resumes.

    if BpodSystem.BeingUsed == 0
        return
    end
end %End main Loop



end

%Internal function for plots
function UpdateOutcomePlot(TrialTypes, Data, LivePlots) %UpdateOutcomePlot(TrialTypes, Data)
global BpodSystem

TrialTypesOriginal=TrialTypes;
TrialTypes=TrialTypes./TrialTypes;
Outcomes = zeros(1,Data.nTrials);
for x = 1:Data.nTrials
    if ~isnan(Data.RawEvents.Trial{x}.States.Drinking(1))
        Outcomes(x) = 1;
    else
        Outcomes(x) = 3;
    end
end

if LivePlots
    TrainingLev2_PlotFile;
end

TrialTypeOutcomePlot(BpodSystem.GUIHandles.OutcomePlot,'update',Data.nTrials+1,TrialTypes,Outcomes); %aplicar la ñera para que solo salga 1 punto en lugar de 8 hahahahaha (TrialTypes -> 1) (Sorry for my comment in spanish but is important for me to rember this, basically I applied a trick to handle more EASILY the outcome plot)
set(BpodSystem.GUIHandles.OutcomePlot,'YTickLabel', {'Other', 'Other', 'Right'}, 'FontSize', 11);
% Update Trial count / Trial Type / Block number

set(BpodSystem.GUIHandles.TrialNumberDisplay, 'String', num2str(Data.nTrials+1));
set(BpodSystem.GUIHandles.TrialTypeDisplay, 'String', num2str(TrialTypesOriginal(Data.nTrials+1)));
set(BpodSystem.GUIHandles.BlockNumberDisplay, 'String', num2str(1));
