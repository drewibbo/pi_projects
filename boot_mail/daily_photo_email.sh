filedate=$(date +"%d-%m-%Y")

fswebcam -r 1920x1080 -S 15 --jpeg 95 --shadow --title "IbboCam" --subtitle "Norfolk House, Chapel Road, Worthing..." --info "Monitor: Active" --save /home/pi/projects/boot_mail/files/$filedate.jpg

sleep 5

python /home/pi/projects/boot_mail/mail_attach.py

exit
