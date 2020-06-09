function SelectMouse2(MouseNumber)
%tic
global CsystemObject
try
    Csystem = evalin('base', 'Csystem');
catch
    disp('Initializing Connection. . .');
    evalin ('base', 'StartCsystem2');
    disp('Csystem Online!');
    Csystem = evalin('base', 'Csystem');
end
UsingBpod = 0;
% try
%     Ser = evalin('base', 'Ser');
%     UsingBpod = 1;
% catch
% end
%[Direction DistanceTraveled] = FindMouseDirection(CsystemObject.SelectedMouse, MouseNumber);


NewMouse = MouseNumber;
MouseNumber = MouseNumber + 4;
if MouseNumber < 4
    MouseNumber = 4;
end
if MouseNumber > 16
    MouseNumber = 16;
end
tic
fwrite(Csystem, [char(78) char(MouseNumber)]);
disp(['Transmitting mouse ID took: ' num2str(toc) ' seconds.'])
pause(.5)
flushinput(Csystem);

Moving = 0;
SmartDelay = 1; % Set SmartDelay = 1 if you want to move as soon as the mouse is selected (shorter delays for nearby mice)
if SmartDelay == 1
while Moving == 0
    Moving = fread(Csystem, 1);
    %Moving = Csystem1('DigitalRead', 8');
    if UsingBpod == 1
%         fwrite(Ser, [char('A') char(37)]);
%         NotSafe = fread(Ser, 1);
%         if NotSafe == 0
%         pause(.01);
%         fwrite(Ser, [char('A') char(39)]);
%         NotSafe = fread(Ser, 1);
%         end
%         if NotSafe == 0
%         pause(.01);
%         fwrite(Ser, [char('A') char(38)]);
%         NotSafe = fread(Ser, 1);
%         end
%         if NotSafe == 1
%             CsystemMotorPower(0);
%             SafeAgain = 0;
%             disp('EMERGENCY STOP!')
%             while (SafeAgain == 0)
%                 pause(.01);
%                 fwrite(Ser, [char('A') char(36)]);
%                 SafeAgain = fread(Ser, 1);
%             end
%             CsystemMotorPower(1);
%             disp('ALL CLEAR')
%         end
    end
    pause(.01);
end
else
    if CsystemObject.PreviousCommandHome
        pause(12.0225);
    else
    pause(6); % The time of the longest possible movement between positions of the carousel

    end
end
CsystemObject.PreviousCommandHome = 0;
CsystemObject.SelectedMouse = NewMouse;

