' MicroBasic Script for UGV Encoding
' We don't have to declare variables, the 
Encoder:
    ' Read Encoder Speed (RPM) for Channel 1 and 2
    ' _S is a internal runtime ID for Speed; the 1 and 2 specify the specific channel.
    rpmPPR1 = getvalue(_S, 1) 
    rpmPPR2 = getvalue(_S, 2)

    ' Safety Check in the case that we need to stop the UGV
    ' 3500 is the RPM limit
    ' setcommand changes a value
    ' _G is the internal runtime ID for "Go"
    ' 1 and 2 are the specific channel
    ' 0 means no power
    if (rpmPPR1 > 3500 or rpmPPR2 > 3500) then
        setcommand(_G, 1, 0)
        setcommand(_G, 2, 0)
        print("RPM/Speed exceeded, stopping\r")
    end if

    ' If no command from Pi 5 for 500ms, stop is added incase of any mishaps 
    ' _STW is the serial time watchdog; it basically is asking, "how long has it been since the pi last sent a command to channel 1 and 2?"
    ' Basically meant to detect any software errors/crash
    if (getvalue(_STW, 1) > 500) then
        setcommand(_G, 1, 0)
        setcommand(_G, 2, 0)
    end if

    wait(10) 
'Jump
    goto Encoder
