function CsystemGate(State)
%tic
global CsystemObject
try
    Csystem = evalin('base', 'Csystem');
catch
    disp('Initializing Connection. . .');
    evalin ('base', 'StartCsystem');
    disp('Csystem Online!');
    Csystem = evalin('base', 'Csystem');
end

if State == 0
    %fwrite(Csystem, [char(78) char(4) char(0)]); %This line can open the
    %door because send the same signal to open it char(78) char(4)
    fwrite(Csystem, [char(78) char(78) char(0)]);
else
    fwrite(Csystem, [char(78) char(4)]);
end
CsystemObject.GateOpen = State;
if State == 0
    %pause(.5);
    pause(2);
    flushinput(Csystem);
%     Moving = 0;
%     while Moving == 0
%         Moving = Csystem1('DigitalRead', 8);
%         pause(.01);
%     end
else
    pause(2);
end