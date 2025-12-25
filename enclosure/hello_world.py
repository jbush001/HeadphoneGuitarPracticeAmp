from build123d import *

pcb = import_step("logic_board.step")

with BuildPart() as hello_world_part:
    Box(7, 7, 20)

export_stl(hello_world_part.part, "hello_world.stl")

assembly = Compound(children=[hello_world_part.part, pcb])
export_stl(assembly, "enclosure_stackup_section.stl")
