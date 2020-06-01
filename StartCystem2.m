clc
if exist('Csystem')
    fwrite(Csystem, [char(67) char(67) char(67)]); %Cancel and exit from waiting commands
    fclose(Csystem);
    delete(Csystem);
    clear Csystem
    clear CsystemObject
    clear TestSer
end
global CsystemObject
disp('Searching for a Csystem microcontroller. Please wait.')
serialInfo = instrhwinfo('serial');
% CsysPorts = serialInfo.AvailableSerialPorts;
CsysPorts = cell(1,1);
CsysPorts{1} = 'COM10'; %port in known to be directly connected to Csystem microcontroller
Found = 0;
for x = 1:length(CsysPorts)
    disp(['Trying port ' CsysPorts{x}])
    TestSer = serial(CsysPorts{x}, 'BaudRate', 115200, 'DataBits', 8, 'Timeout', 1, 'DataTerminalReady', 'on');%  , 'RequestToSend', 'on');
    fopen(TestSer);
    set(TestSer, 'RequestToSend', 'on');
    fprintf(TestSer, char(73));
    tic
    g = 0;
    try
        g = fread(TestSer, 1);
    catch
        % ok
    end
    if g == '5'
        Found = x;
        fclose(TestSer);
        delete(TestSer)
        clear TestSer;
        clc;
    end
 
end
pause(.1);
if Found ~= 0
Csystem = serial(CsysPorts{Found});
else
    error('Could not find a valid Csystem microcontroller');
end

set(Csystem,'BaudRate',115200);
set(Csystem,'DataBits',8);
set(Csystem,'StopBits',1);
set(Csystem, 'OutputBufferSize', 8000);
set(Csystem, 'InputBufferSize', 8000);
fopen(Csystem);
set(Csystem, 'RequestToSend', 'on');
fwrite(Csystem, char(73));
tic
while Csystem.BytesAvailable == 0
    if toc > 1
        break
    end
end
fread(Csystem, Csystem.BytesAvailable);
set(Csystem, 'RequestToSend', 'off')



% fwrite(Csystem, char(67)); % C
% fwrite(Csystem, char(73)); % I
% fwrite(Csystem, char(82)); % R

% %For safety and security purpose in order to execute a command first you'll
% %need a 'N' (next command) byte before your real selection. 
% fwrite(Csystem, [char(78) char(5)]); % 
% 
% %if you one to cancel once Csystem2 is ready for  commands need :
% fwrite(Csystem, [char(67) char(67) char(67)]); % C 
% %this is because after ReadyForCommands Arduino is reading 2 bytes so never
% %reach commandByte (should I improve this later). So you need to send 3
% %bytes and then serialUSB.available will have at least 1 byte to read. 

% fread(TestSer, 1)
disp(['Success! Csystem is ready on port ' CsysPorts{Found}])
fwrite(Csystem, char(82)); % R: send signal controller to allow the use of commands 
disp('Ready for commands')
clear Found g x Ports serialInfo

fwrite(Csystem, [char(78) char(78) char(0)]); %This command is to be sure that door will be close before run HomeCystem command

% COMMENTED THE FOLLOWING LINES TO TEST STUFF remember decommented
tic();
HomeCsystem2
disp('Finding home position... please wait');
pause(2)
flushinput(Csystem);
Moving = 0;
while Moving == 0
    Moving = fread(Csystem, 1); %Csystem1('DigitalRead', 8);
    pause(.01);
end
HomePositionTime = toc();
disp('Done, it took:');
disp(HomePositionTime);

CsystemObject = struct;
CsystemObject.SelectedMouse = 1;
CsystemObject.GateOpen = 0;
CsystemObject.PreviousCommandHome = 1;