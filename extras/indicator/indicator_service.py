import multiprocessing
import time

import board
import neopixel
import zerorpc

# https://learn.adafruit.com/circuitpython-led-animations/basic-animations
# https://circuitpython.readthedocs.io/projects/neopixel/en/latest/api.html
# https://learn.adafruit.com/neopixels-on-raspberry-pi/python-usage
# https://www.raspberrypi-spy.co.uk/2012/06/simple-guide-to-the-rpi-gpio-header-and-pins/
# https://dzone.com/articles/python-thread-part-1


# Choose an open pin connected to the Data In of the NeoPixel strip, i.e. board.D18
# NeoPixels must be connected to D10, D12, D18 or D21 to work.
pixel_pin = board.D18

# The number of NeoPixels
num_pixels = 4
# The order of the pixel colors - RGB or GRB. Some NeoPixels have red and green reversed!
# For RGBW NeoPixels, simply change the ORDER to RGBW or GRBW.
ORDER = neopixel.GRB
pixels = neopixel.NeoPixel(
    pixel_pin, num_pixels, brightness=0.2, auto_write=False, pixel_order=ORDER)
stop_thread = False

def wheel(pos):
    # Input a value 0 to 255 to get a color value.
    # The colours are a transition r - g - b - back to r.
    if pos < 0 or pos > 255:
        r = g = b = 0
    elif pos < 85:
        r = int(pos * 3)
        g = int(255 - pos * 3)
        b = 0
    elif pos < 170:
        pos -= 85
        r = int(255 - pos * 3)
        g = 0
        b = int(pos * 3)
    else:
        pos -= 170
        r = 0
        g = int(pos * 3)
        b = int(255 - pos * 3)
    return (r, g, b) if ORDER in (neopixel.RGB, neopixel.GRB) else (r, g, b, 0)


def rainbow_cycle(wait):
    for j in range(255):
        for i in range(num_pixels):
            pixel_index = (i * 256 // num_pixels) + j
            pixels[i] = wheel(pixel_index & 255)
        pixels.show()
        time.sleep(wait)


def run(mode):
    if mode != 0:
        while True:
            if mode == 1:
                # Comment this line out if you have RGBW/GRBW NeoPixels
                pixels.fill((255, 0, 0))
                # Uncomment this line if you have RGBW/GRBW NeoPixels
                # pixels.fill((255, 0, 0, 0))
                pixels.show()
                time.sleep(1)

                # Comment this line out if you have RGBW/GRBW NeoPixels
                pixels.fill((0, 255, 0))
                # Uncomment this line if you have RGBW/GRBW NeoPixels
                # pixels.fill((0, 255, 0, 0))
                pixels.show()
                time.sleep(1)

                # Comment this line out if you have RGBW/GRBW NeoPixels
                pixels.fill((0, 0, 255))
                # Uncomment this line if you have RGBW/GRBW NeoPixels
                # pixels.fill((0, 0, 255, 0))
                pixels.show()
                time.sleep(1)
            if mode == 2:
                rainbow_cycle(0.001)  # rainbow cycle with 1ms delay per step
                pixels.brightness = 0.1
            if mode == 3:
                pixels.fill((255, 0, 0))
                pixels.show()
            if mode == 4:
                pixels.fill((0, 255, 0))
                pixels.show()
            if mode == 5:
                pixels.fill((0, 0, 255))
                pixels.show()


    else:
        pixels.fill(0x0000)
        pixels.show()


class HelloRPC(object):
    def __init__(self):
        self.process = None
        run(0)

    def mode(self, pattern):
        if self.process is not None:
            self.process.terminate()
        if pattern != 0:
            self.process = multiprocessing.Process(target=run, args=(pattern,))
            self.process.start()
        else:
            run(0)

        return pattern


s = zerorpc.Server(HelloRPC())
s.bind("tcp://0.0.0.0:4242")
s.run()
