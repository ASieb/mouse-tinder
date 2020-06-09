function HomeCsystem2()

try
    Csystem = evalin('base', 'Csystem');
catch
    disp('Initializing Connection. . .');
    evalin ('base', 'StartCsystem');
    disp('Csystem Online!');
    Csystem = evalin('base', 'Csystem');
end


fwrite(Csystem, [char(78) char(1)]);  %Excute home spot in carousel system, in other words, function 1: HOME



