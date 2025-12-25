from build123d import *

pcb = import_step("logic_board.step")
export_stl(pcb, "enclosure_stackup_section.stl")
