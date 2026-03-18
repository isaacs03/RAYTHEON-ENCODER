import serial
import time

class UGVController:
    def __init__(self, port='/dev/ttyUSB0'):
        # Initialize Serial connection to HDC2460
        self.ser = serial.Serial(port, 115200, timeout=0.1)
        print(f"Connected to Roboteq on {port}")

    def set_motor_speeds(self, left_pwr, right_pwr):
        """Sends power commands (-1000 to 1000)"""
        cmd = f"!G 1 {left_pwr}\r!G 2 {right_pwr}\r"
        self.ser.write(cmd.encode())

    def get_encoder_counts(self):
        """Queries the absolute encoder position"""
        self.ser.write(b"?C 1\r?C 2\r")
        # Read the response from the controller
        response = self.ser.read_all().decode()
        return response

# --- Example Usage for your Mission ---
ugv = UGVController()

try:
    while True:
        # 1. Command: Drive Forward at 30% power
        ugv.set_motor_speeds(300, 300)
        
        # 2. Feedback: Ask where we are
        pos = ugv.get_encoder_counts()
        print(f"Current Encoder Positions: {pos}")
        
        time.sleep(0.1) # 10Hz Loop

except KeyboardInterrupt:
    ugv.set_motor_speeds(0, 0) # Hard stop on exit
