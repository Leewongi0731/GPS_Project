serialObj = serial('COM6', 'BaudRate', 57600);
set(serialObj,'InputBufferSize', 2^25);
set(serialObj, 'FlowControl', 'software');

timeSetting = 300;

fopen(serialObj);
fid = fopen('../rinexData/sourceData.txt', 'w');

startT = clock;
startSec =  startT(4) * 3600 + startT(5) * 60 + startT(6);
ublox_poll_message(serialObj, 'AID', 'EPH', 0)

while 1
    updateT = clock;
    updataSec = updateT(4) * 3600 + updateT(5) * 60 + updateT(6);
    if(updataSec - startSec) >= timeSetting
        fprintf('%5d',clock)
        fprintf('\n')
        
        startSec = updataSec;
        
        ublox_poll_message(serialObj, 'AID', 'EPH', 0);
        fclose(fid);
        fid = fopen('../rinexData/sourceData.txt', 'w');
        
    end
    fprintf(fid, "%02x", fscanf(serialObj));
end

fclose(fid);
fclose(serialObj);