' MicroBasic Script for Raytheon UGV
' Goal: Monitor encoders and provide a safety watchdog

top:
    ' 1. Read Encoder Speed (RPM) for Channel 1 and 2
    Speed1 = getvalue(_S, 1) 
    Speed2 = getvalue(_S, 2)

    ' 2. Safety Check: If speed exceeds a "Dangerous" limit, E-Stop
    ' (Useful for high-torque AmpFlow motors)
    if (Speed1 > 3500 or Speed2 > 3500) then
        setcommand(_G, 1, 0)
        setcommand(_G, 2, 0)
        print("SAFETY CRITICAL: SPEED LIMIT EXCEEDED\r")
    end if

    ' 3. Heartbeat: If no command from Pi 5 for 500ms, Stop
    if (getvalue(_STW, 1) > 500) then
        setcommand(_G, 1, 0)
        setcommand(_G, 2, 0)
    end if

    wait(10) ' Run loop at 100Hz
    goto top
