#from bottle import Bottle, run, template, get, post, request
from bottle import Bottle, run, template, request
import serial, time, socket

ser = serial.Serial()
ser.port='/dev/ttyUSB0'
ser.baudrate=9600
ser.timeout=5

app = Bottle()

@app.route('/')
def index():
	s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	s.connect(('8.8.8.8', 0))
	local_ip_address = s.getsockname()[0]
	return template('instructions.tpl',ipaddress=local_ip_address)

@app.route('/status')
def fullstatus():
	ser.open()
	ser.write("?11PR\r\n")
	time.sleep(1)
	response = ser.read(9)
	print response
	return(response)
	ser.close()

@app.route('/status/<zone>')
def status(zone='11'):
	ser.open()
	print zone
	command = "?%sPR\r\n" % (zone)
	print command
	ser.write(command)
	time.sleep(1)
	response = ser.read(20)
	print response
	ser.close()
	return template('command:{{status}}', status=response)
	#return response

@app.route('/send', method='POST')
def sendCommand():
	#print command
	#ser.open()
	#ser.write(command)
	#time.sleep(1)
	#response = ser.read(9)
	#print response
	#return template('command:{{response}}', response=response)
	#ser.close()

	command = request.forms.get('command')
	command="<%s\r\n" % (command)
	print command
	ser.open()
	ser.write(command)
	time.sleep(1)
	response = ser.read(9)
	print response
	return template('command:{{status}}', status=response)
	ser.close()

run(app, host='0.0.0.0', port=8000)
