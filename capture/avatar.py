import cv
import time


camera = cv.CaptureFromCAM(0)
cv.SetCaptureProperty(camera, cv.CV_CAP_PROP_FRAME_WIDTH, 320)
cv.SetCaptureProperty(camera, cv.CV_CAP_PROP_FRAME_HEIGHT, 240)
#cv.SetCaptureProperty(camera, cv.CV_CAP_PROP_FPS, 30)
memstorage =  cv.CreateMemStorage()
        
init_frames = 20
while True:
    im = cv.QueryFrame(camera)
    cv.ShowImage("CamView", im)
    #hsv = cv.CreateMat(im.width, im.height, cv.CV_8UC3)
    hsv = cv.CloneImage(im)
    #cv.CvtColor(im, hsv, cv.CV_RGB2HSV)

    #cv.ShowImage("HSV", hsv)
    #channelh = cv.CreateMat(im.height, im.width, cv.CV_8UC1)
    #channels = cv.CreateMat(im.height, im.width, cv.CV_8UC1)
    #channelv = cv.CreateMat(im.height, im.width, cv.CV_8UC1)
    mono = cv.CreateMat(im.height, im.width, cv.CV_8UC1)
    #cv.Split(hsv, channelh, channels, channelv, None)
    #cv.ShowImage("Channelh", channelh)
    #cv.ShowImage("Channels", channels)
    #cv.ShowImage("Channelv", channelv)
    cv.CvtColor(im, mono, cv.CV_RGB2GRAY)
    cv.Canny(mono, mono, 60, 80)
    cv.ShowImage("Mono", mono)
    
           
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
        v += STEP
        move()
    if c == ord('s'):
        v -= STEP
        move()
    if c == ord('r'):
        cv.SaveImage("avatar.jpg", mono)    


