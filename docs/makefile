docs: rt1.pdf

archive: rt1docs.zip

rt1.pdf: ./rt1.tex
	#gschem rt1cotton.sch -o rt1cotton.ps -p -s print.scm
	latex rt1.tex
	dvips rt1.dvi
	ps2pdf rt1.ps
	#evince rt1.pdf

rt1docs.zip: ../control/joystick.py ../control/port_settings ../control/start.sh ../control/clientstart.sh ../arduino/car3/car3.pde ./rt1.pdf
	zip -j rt1docs.zip ../control/joystick.py ../control/port_settings ../control/start.sh ../control/clientstart.sh ../arduino/car3/car3.pde ./rt1.pdf

send: rt1docs.zip
	scp -P 2200 rt1docs.zip dreamantle@dreamantle.ru:~/www
