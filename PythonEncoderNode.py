import serial
import time

class UGVController:
    def __init__(self, port='/dev/ttyUSB0'):
        # Initialize Serial connection to HDC2460
        # self.ser creates an object called ser which belongs to this class; '/dev/ttyUSB0' is the string path to the usb port
        self.ser = serial.Serial(port, 115200, timeout=0.1)
        print(f"Connected to Roboteq on {port}")
        
        # Translates so our motor controller understands
        # left_pwr and right_pwr are variables that control the motor channel on our Roboteq motor controller which is wired to our brushed motors
    def set_motor_speeds(self, left_pwr, right_pwr):
        
        # Sends power commands (-1000 to 1000)
        # !G 1 is for the left motor and !G 2 is for the right motor
        cmd = f"!G 1 {left_pwr}\r!G 2 {right_pwr}\r"
        self.ser.write(cmd.encode())

    def get_encoder_counts(self):
        """Queries the absolute encoder position"""
        # This is the query; Basically asks, give me the count for motor 1 and motor 2 in bytes
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
