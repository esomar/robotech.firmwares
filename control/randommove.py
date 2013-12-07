#!/usr/bin/python -u

import pygame
import random
v = 90
h = 90
engine = 90
s = 90
STEP = 6
dolog = True
manual = False

def domove():
    global h, v, engine, s, on
    #engine = int(254 * values['E'])
    #s = 110-int(90 * values['S'])
    h = random.randrange(180)
    v = random.randrange(180)
    print "h "+str(h)
    print "v "+str(v)
    print "e "+str(engine)
    print "s "+str(s)
    if manual:
        print "led on"
    else:
        print "led off"    


def handleJoyEvent(event):
    global h, v, engine, s, manual  
    if event.type == pygame.JOYAXISMOTION:  
        axis = ""  
        if   (event.dict['axis'] == 0):  
            axis = "S"  
        elif (event.dict['axis'] == 1):   
            axis = "E"  
        elif (event.dict['axis'] == 3):  
            axis = "H"  
        elif (event.dict['axis'] == 4):  
            axis = "V"  
    
        if (axis != ""):  
            values[axis]=event.dict['value']
            if not manual:
                h = 90-int(70 * values['H'])
                v = 90+int(70 * values['V'])

    if event.type == pygame.JOYBUTTONDOWN:
        if event.dict["button"]==5:
            manual = not manual
        elif event.dict["button"]==0:
	    v = v -1
        elif event.dict["button"]==2:
            v = v +1
        elif event.dict["button"]==1:
            h = h -1
        elif event.dict["button"]==3:
            h = h +1

def joystickControl():  
    pygame.time.set_timer(pygame.USEREVENT, 5000)
    while True:  
        e = pygame.event.wait()
        #if (e.type == pygame.JOYAXISMOTION or e.type == pygame.JOYBUTTONDOWN):
        #    handleJoyEvent(e)
        if (e.type == pygame.USEREVENT):
            domove()

values = {"H":0, "V":0, "E": 0, "S": 0}
def main():  
    pygame.joystick.init()  
    pygame.display.init()
    myjoy = pygame.joystick.Joystick(0)  
    myjoy.init()
    joystickControl()
    
if __name__ == "__main__":
    main()
