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

	count = 1
	response = ""
	while (count < 7):
		command = "?1" + `count` + "PR\r\n"
		ser.write(command)
		line = ser.readline()
		time.sleep(2)
		response = response + "\r\n" + ser.read(20)
		count = count + 1
	return(response)
	ser.close()

@app.route('/status/<zone>')
def status(zone='11'):
	ser.open()
	command = "?%sPR\r\n" % (zone)
	ser.write(command)
	time.sleep(2)
	response = ser.read(20)
	ser.close()
	return response

@app.route('/send', method='POST')
def sendCommand():
	command = request.forms.get('command')
	command="<%s\r\n" % (command)
	ser.open()
	ser.write(command)
	time.sleep(2)
	response = ser.read(20)
	return template('command:{{status}}', status=response)
	ser.close()

run(app, host='0.0.0.0', port=8000)
