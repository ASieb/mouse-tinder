function OpenBlackDoor

sma = NewStateMatrix();
sma = AddState(sma, 'Name','DoorOpen',...
    'Timer',0.001,... %0.001
    'StateChangeConditions',{'Tup','exit'},...
    'OutputActions',{'WireState', 1});% OPEN BLACK DOOR
SendStateMatrix(sma);
pause(.1);
RunStateMatrix;

    %%Change to wirestate, 2 from wirestate, 1 in order to sanity check.
    %%door was opening/closing opposite. AAS 2/25/20