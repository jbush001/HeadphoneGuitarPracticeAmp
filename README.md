## Background

I was looking for a headphone guitar amp with the following features:

- Integrated guitar plug: Doesn't require an extra cable or have a box
  flopping around.
- Rechargeable battery
- Flexible set of basic effects with decent quality: distortion, reverb,
  amp simulation, etc.
- Built-in metronome

Although there are commercially available headphone amps that support a few of
these, surprisingly, none supported all of them, so I decided to build my own.
The heart of this is an ARM microcontroller, which processes the audio signal
and applies digital effects. The hardware consists of a custom printed circuit
board in a 3D printed enclosure.

## Setup (MacOS)

### CAD

This uses the build123d package for all CAD design. To set up:

    python3 -m venv .venv
    pip install -r requirements.txt

When starting a new terminal/session:

    source ./venv/bin/activate

You can regenerate the generated STL file by typing:

    python hello_world.py

The STL file can be viewed with a system viewer.

(Note, this may not work from the VSCode terminal, as it needs to separately set
the python environment).

### Schematic

Install the latest version of KiCAD from here <https://www.kicad.org/download/>.

If the board profile or parts are updated, re-export the 3d model (to be used
in rendering the stackup). From the board editor, select the menu
File -> Export -> STEP/GLB/STL... Select format STEP, select the 'logic_board'
directory, press the 'Export' button.

In order to generate output files suitable for fabrication and assembly by
JLCPCB <https://jlcpcb.com/>, use the following steps:

From the PCB Editor:
- Open the menu File -> Fabrication Outputs -> Gerber Files.
  Select plot format "Gerber". Set the output directory to the fabrication subdirectory.
  Press the 'plot' button.
  (Should double check these by double clicking to open the gerber viewer)
- Open the menu File -> Fabrication Outputs -> Drill Files.
  Press the 'Generate' button.
- Open the menu Fabrication Outputs -> Component placement.
  Hand modify the first line of the CSV file, replacing it with:
  Ref,Val,Package,Mid X,Mid Y,Rotation,Layer
From the schematic editor:
- Open the menu Tools -> Generate Bill of Materials. Click the export button.
  (This will be in the logic_board directory).
  Ensure these all have the proper LCSC part numbers <https://jlcpcb.com/parts>

The contents of the fabrication folder can be zipped up and uploaded to JLCPCB's site.
You'll also need to separately upload the placement and BOM files.

### Software

Software can be uploaded using the ST-Link v2 programmer:

<https://www.adafruit.com/product/2548?srsltid=AfmBOoq6BzHUY0KrrB4XPQAl0OvnK3d9qYIsi6UlSETSzX4CNc_bk4Xj>
