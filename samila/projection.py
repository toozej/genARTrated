# Projection
# <https://github.com/sepandhaghighi/samila#projection>

import core
import matplotlib.pyplot as plt
from samila import GenerativeImage
from samila import Projection

def projection(timestamp):
    g = GenerativeImage(core.f1,core.f2)

    g.generate()
    g.plot(projection=Projection.POLAR)
    g.save_image(file_adr=f"/out/projection_{timestamp}.png", depth=5)
    g.save_data(file_adr=f"/out/projection_{timestamp}.json")

    # return seed for use in other functions
    return g.seed
