import cv

camera = cv.CaptureFromCAM(0)
#cv.SetCaptureProperty(camera, cv.CV_CAP_PROP_FRAME_WIDTH, 320)
#cv.SetCaptureProperty(camera, cv.CV_CAP_PROP_FRAME_HEIGHT, 240)
#cv.SetCaptureProperty(camera, cv.CV_CAP_PROP_FPS, 30)



def move():
    global e
    global s
    global v
    global h
    if e > 80  and e <100:
        e = 90
    if e > 180:
        e = 180
    if e<0:
        e = 0
    if s > 90:
        s = 91
    if s< 89:
        s = 89    
    f = open ("/dev/ttyUSB0", "a")
    f.write("h "+str(h)+chr(10))
    f.write("v "+str(v)+chr(10))
    f.write("e "+str(e)+chr(10))
    f.write("s "+str(s)+chr(10))
    f.close()


v = 90;
h = 90;
e = 90;
s = 90;
STEP = 6
ENSTEP = 30
SSTEP = 1
cv.NamedWindow("CamView")
while True:
    im = cv.QueryFrame(camera)
    cv.ShowImage("CamView", im)
#    im = cv.CreateMat(im)
    c = cv.WaitKey(33)
    if c ==27:
        break
    if c == ord('a'):
        h += STEP
        move()
    if c == ord('d'):
        h -= STEP
        move()
    if c == ord('w'):
        v -= STEP
        move()
    if c == ord('s'):
        v += STEP
        move()
    if c == ord('i'):
        e += ENSTEP
        move()
    if c == ord('k'):
        e -= ENSTEP
        move()
    if c == ord('j'):
        s += SSTEP
        move()
    if c == ord('l'):
        s -= SSTEP
        move()

