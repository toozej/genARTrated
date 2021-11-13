# Range
# <https://github.com/sepandhaghighi/samila#range>

import core
import math
import matplotlib.pyplot as plt
from samila import GenerativeImage

def range(timestamp):
    g = GenerativeImage(core.f1,core.f2)

    g.generate(start = -2*math.pi,step=0.1,stop=0)
    g.plot()
    g.save_image(file_adr=f"/out/range_{timestamp}.png", depth=5)
    g.save_data(file_adr=f"/out/range_{timestamp}.json")
    
    # return seed for use in other functions
    return g.seed
