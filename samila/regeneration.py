# Regeneration
# <https://github.com/sepandhaghighi/samila#regeneration>

import core
import matplotlib.pyplot as plt
from samila import GenerativeImage
from samila import Projection

def regeneration(timestamp):
    g = GenerativeImage(core.f1,core.f2)

    # TODO seed hardcoded for now until I find a good way to pass an optional seed argument from another function, or if not specified have "g" create one itself
    seed = 10
    g.generate(seed=seed)
    g.plot(projection=Projection.POLAR)
    g.save_image(file_adr=f"/out/regeneration_{timestamp}.png", depth=5)
    g.save_data(file_adr=f"/out/regeneration_{timestamp}.json")

    # return seed for use in other functions
    return g.seed
