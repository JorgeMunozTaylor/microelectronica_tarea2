#    Tarea 2
#    Microelectrónica
#    Creado por Jorge Muñoz Taylor
#    Carné A53863
#    II-2020

ALL: probarA probarB probarC

probarA:
	@mkdir -p ./bin
	@mkdir -p ./logs
	@iverilog -o ./bin/PRUEBA ./testbench/testbench.v 
	@vvp ./bin/PRUEBA
	@gtkwave ./bin/prueba.vcd


clean:
	rm -rf ./bin ./logs