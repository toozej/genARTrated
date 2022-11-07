import subprocess
from datetime import datetime

# get current time
now = datetime.now()
# format timestamp for use in filenames
# example: 20211113-114001 for Nov 13th 2021 at 11:40:01
timestamp = now.strftime("%Y%m%d-%H%M%S")

# Newton fractal algorithm
# <https://en.wikipedia.org/wiki/Newton_fractal>
newton_filename = f"/out/newton_{timestamp}.png"
newton = subprocess.run(
    [
        "anovik/fractals.py",
        "--algorithm",
        "newton",
        "--colormap",
        "RdYlBu",
        "--output",
        newton_filename,
    ],
    # stdout=subprocess.DEVNULL,
    # stderr=subprocess.DEVNULL,
    capture_output=True,
)
# print(str(newton.stdout))
# print(str(newton.stderr))

# Burning Ship fractal algorithm
# <https://en.wikipedia.org/wiki/Burning_Ship_fractal>
burningship_filename = f"/out/burningship_{timestamp}.png"
burningship = subprocess.run(
    [
        "anovik/fractals.py",
        "--algorithm",
        "burningShip",
        "--colormap",
        "hot",
        "--xmin",
        "-2",
        "--xmax",
        "2",
        "--ymin",
        "-2",
        "--ymax",
        "2",
        "--output",
        burningship_filename,
    ],
    # stdout=subprocess.DEVNULL,
    # stderr=subprocess.DEVNULL,
    capture_output=True,
)
# print(str(burningship.stdout))
# print(str(burningship.stderr))
