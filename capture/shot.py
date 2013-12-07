import Image
from pygame.locals import *
import sys

import opencv
#this is important for capturing/displaying images
from opencv import highgui 

camera = highgui.cvCreateCameraCapture(0)
def get_image():
    img = highgui.cvQueryFrame(camera)
    # Add the line below if you need it (Ubuntu 8.04+)
    #im = opencv.cvGetMat(im)
    #convert Ipl image to PIL image
    print img
    return opencv.adaptors.Ipl2PIL(img) 

im = get_image()
im.save("test.bmp")
