#!/usr/bin/env python
import smtplib
import time
from email.MIMEMultipart import MIMEMultipart
from email.MIMEBase import MIMEBase
from email.MIMEText import MIMEText
from email.Utils import COMMASPACE, formatdate
from email import Encoders
import os

LOGNAME = time.strftime("%d-%m-%Y")
FILETOSEND = "".join([LOGNAME, ".jpg"])

tfile = open("/sys/bus/w1/devices/28-00000495b443/w1_slave")
text = tfile.read()
tfile.close()
temperature_data = text.split()[-1]
temperature = float(temperature_data[2:])
temperature = temperature / 1000

time.sleep(4)

USERNAME = "andyibbitson@gmail.com"
PASSWORD = "monkeykangaroo"

def sendMail(to, subject, text, files=[]):
    assert type(to)==list
    assert type(files)==list

    msg = MIMEMultipart()
    msg['From'] = USERNAME
    msg['To'] = COMMASPACE.join(to)
    msg['Date'] = formatdate(localtime=True)
    msg['Subject'] = subject
    
    msg.attach( MIMEText(text) )

    for file in files:
        part = MIMEBase('application', "octet-stream")
        part.set_payload( open(file,"rb").read() )
        Encoders.encode_base64(part)
        part.add_header('Content-Disposition', 'attachment; filename="%s"'
                       % os.path.basename(file))
        msg.attach(part)

	server = smtplib.SMTP('smtp.gmail.com:587')
	server.ehlo_or_helo_if_needed()
	server.starttls()
	server.ehlo_or_helo_if_needed()
	server.login(USERNAME,PASSWORD)
	server.sendmail(USERNAME, to, msg.as_string())
	server.quit()


sendMail( ["drewibbo@live.com"],
        "Your daily email Drewibbo...",
        "Hello Andy \n Attached is your daily photo from home. \n The temperature is: " + str(temperature) + "C. \n \n Have a nice day :) \n",
        ["/var/www/worthingwatch/images/" + FILETOSEND,"/var/www/worthingwatch/images/file.txt"] )
