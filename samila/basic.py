# Basic
# <https://github.com/sepandhaghighi/samila#basic>

import core
import matplotlib.pyplot as plt
from samila import GenerativeImage

def basic(timestamp):
    g = GenerativeImage(core.f1,core.f2)

    g.generate()
    g.plot()
    g.save_image(file_adr=f"/out/basic_{timestamp}.png", depth=5)
    g.save_data(file_adr=f"/out/basic_{timestamp}.json")

    # return seed for use in other functions
    return g.seed
