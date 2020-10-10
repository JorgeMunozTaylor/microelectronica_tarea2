#    Tarea 2
#    Microelectrónica
#    Creado por Jorge Muñoz Taylor
#    Carné A53863
#    II-2020

ALL: probar probar_synt probar_retardo

YOSYS:
	@yosys yosys_conf.ys

probar:
	@mkdir -p ./bin
	@mkdir -p ./logs
	@iverilog -o ./bin/PRUEBA ./testbench/testbench.v 
	@vvp ./bin/PRUEBA
	@gtkwave ./bin/prueba.vcd


probar_synt:
	@mkdir -p ./bin
	@mkdir -p ./logs
	@iverilog -o ./bin/PRUEBA ./testbench/testbench_synt.v cells/cmos_cells.v
	@vvp ./bin/PRUEBA
	@gtkwave ./bin/prueba.vcd


probar_retardo:
	@mkdir -p ./bin
	@mkdir -p ./logs
	@iverilog -o ./bin/PRUEBA -gspecify ./testbench/testbench_synt.v cells/cmos_cells.v
	@vvp ./bin/PRUEBA
	@gtkwave ./bin/prueba.vcd


clean:
	rm -rf ./bin ./logs