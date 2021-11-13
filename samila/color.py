# Color
# <https://github.com/sepandhaghighi/samila#color>

import core
import matplotlib.pyplot as plt
from samila import GenerativeImage
from samila import Projection

def color(timestamp):
    g = GenerativeImage(core.f1,core.f2)

    g.generate()
    g.plot(color="yellow",bgcolor="black",projection=Projection.POLAR)
    g.save_image(file_adr=f"/out/color_{timestamp}.png", depth=5)
    g.save_data(file_adr=f"/out/color_{timestamp}.json")

    # return seed for use in other functions
    return g.seed
