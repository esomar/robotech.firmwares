import cv
import time
import sys

#hc = cv.Load("haarcascade_frontalface_alt_tree.xml")

# print sys.argv[1]
camera = cv.CaptureFromFile("http://"+sys.argv[1]+"/?action=stream&ignored.mjpg")
#camera = cv.CaptureFromCAM(0)
#cv.SetCaptureProperty(camera, cv.CV_CAP_PROP_FRAME_WIDTH, 320)
#cv.SetCaptureProperty(camera, cv.CV_CAP_PROP_FRAME_HEIGHT, 240)
#cv.SetCaptureProperty(camera, cv.CV_CAP_PROP_FPS, 30)
memstorage =  cv.CreateMemStorage()
v = 90;
h = 90;
STEP = 1
cv.NamedWindow("CamView")

def move():
	print "h", h
	print "v", v    
    #f = open ("/dev/ttyUSB0", "a")
    #f.write("h "+str(h)+chr(10))
    #f.write("v "+str(v)+chr(10))
    #f.close()

        
init_frames = 20
while True:
    im = cv.QueryFrame(camera)
    
    cv.ShowImage("CamView", im)
    
    mono = cv.CreateImage((im.width, im.height), cv.IPL_DEPTH_8U, 1)
    view = cv.CloneImage(im)

    cv.CvtColor(im, mono, cv.CV_RGB2GRAY)
    cv.ShowImage("Gray", mono)
    faces = cv.HaarDetectObjects(mono, hc, memstorage)
    
    
    for (x,y,w,h),n in faces:
        cv.Rectangle(view, (x,y), (x+w,y+h), (255,255,0))
    
    cv.ShowImage("Faces", view)    
    
    #hsv = cv.CreateMat(im.width, im.height, cv.CV_8UC3)
    #hsv = cv.CloneImage(im)
    #cv.CvtColor(im, hsv, cv.CV_RGB2HSV)
    #cv.Smooth(hsv, hsv, cv.CV_MEDIAN, 3)
    maxw = 0
    if len(faces)>0:
      (maxx, maxy, maxw, maxh), n = faces[0]
    if maxw>0:
		if (maxx+maxw/2+20>im.width/2) and (h>10):
		   h -= STEP
		if (maxx+maxw/2-20<im.width/2) and (h<170):
		   h += STEP
		if (maxy+maxh/2-20<im.height/2) and (v<170):
		   v += STEP
		if (maxy+maxh/2+20>im.height/2) and (v>10):
		   v -= STEP
		move()
           
    c = cv.WaitKey(10)
    if c ==27:
        break

    if c == ord('a'):
        h += STEP
        move()
    if c == ord('d'):
        h -= STEP
        move()
    if c == ord('w'):
        v += STEP
        move()
    if c == ord('s'):
        v -= STEP
        move()


