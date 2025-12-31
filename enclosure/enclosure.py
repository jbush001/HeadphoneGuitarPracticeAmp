from build123d import *

PCB_LENGTH = 80 # X
PCB_WIDTH = 30  # Y
PCB_GAP = 0.5
WALL_THICKNESS = 2
ENCLOSURE_OUTER_RADIUS = 4

enclosure_outer_length = PCB_LENGTH + 2 * (WALL_THICKNESS + PCB_GAP)
enclosure_outer_width = PCB_WIDTH + 2 * (WALL_THICKNESS + PCB_GAP)
boss_diam = 4
boss_xoffs = (enclosure_outer_length / 2) - WALL_THICKNESS - boss_diam / 2 - 0.5
boss_yoffs = (enclosure_outer_width / 2) - WALL_THICKNESS - boss_diam / 2 - 0.5

with BuildPart() as top_shell_builder:
    # Top face
    with BuildSketch():
        RectangleRounded(width=enclosure_outer_length,
                         height=enclosure_outer_width,
                         radius=ENCLOSURE_OUTER_RADIUS)
    extrude(amount=WALL_THICKNESS)

    # Cavity
    with BuildSketch(Plane(top_shell_builder.faces().sort_by(Axis.Z)[0])):
        RectangleRounded(width=enclosure_outer_length,
                         height=enclosure_outer_width,
                         radius=ENCLOSURE_OUTER_RADIUS)
        RectangleRounded(width=enclosure_outer_length - 2 * WALL_THICKNESS,
                         height=enclosure_outer_width - 2 * WALL_THICKNESS,
                         radius=ENCLOSURE_OUTER_RADIUS - WALL_THICKNESS,
                         mode=Mode.SUBTRACT)

        # Add mounting bosses
        with Locations(
            Location((boss_xoffs, boss_yoffs)),
            Location((-boss_xoffs, boss_yoffs)),
            Location((boss_xoffs, -boss_yoffs)),
            Location((-boss_xoffs, -boss_yoffs)),
        ):
            Circle(radius=boss_diam / 2)

    extrude(amount=15)
    top_shell = top_shell_builder.part


with BuildPart() as pcb_builder:
    with BuildSketch():
        Rectangle(PCB_LENGTH, PCB_WIDTH)
        with Locations(
            (-PCB_LENGTH / 2, -PCB_WIDTH / 2),
            (PCB_LENGTH / 2, -PCB_WIDTH / 2),
            (PCB_LENGTH / 2, PCB_WIDTH / 2),
            (-PCB_LENGTH / 2, PCB_WIDTH / 2),
        ):
            Circle(5, mode=Mode.SUBTRACT)

    extrude(amount=3)
    standin_pcb = pcb_builder.part

with BuildPart() as battery_builder:
    Box(32.5, 25.5, 5.7)
    battery = battery_builder.part


enclosure_with_standins = Compound(
    label="assembly",
    children = [
        top_shell,
        standin_pcb.moved(Pos(0, 0, -10)),
        battery.moved(Pos(0, 0, -13))
    ]
)

# Create a cutaway
with BuildPart() as cutaway:
    add(enclosure_with_standins)
    with Locations((50, 50, 0)):
        Box(100, 100, 100, mode=Mode.SUBTRACT)

    export_stl(cutaway.part, "cutaway.stl")
