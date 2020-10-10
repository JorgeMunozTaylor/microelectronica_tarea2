/*
    Tarea 1
    Microelectrónica
    Creado por Jorge Muñoz Taylor
    Carné A53863
    II-2020
*/

`ifndef DEFINES_V
`include "./src/defines.v"
`endif


/*
    Recibe la salida Q del contador y su valor anterior para determinar si
    el valor es el correcto.
*/
task verificar_Q
(
    input [3:0] Qi,
    input [3:0] Q_ant,

    output reg Q_fallo
); 

    begin   

        if ( Q_ant === `HiZ )
            Q_fallo = ( Qi === `HiZ || Qi == 4'b0000 )? `BAJO:`ALTO;
          
        else
            Q_fallo = ( Qi === Q_ant )? `BAJO:`ALTO;
                
    end 

endtask


/*
    Recibe la salida load del contador para determinar si
    el valor es el correcto.
*/
task verificar_LOAD
(
    input LOAD,
    input LOAD_CHECK,

    output reg LOAD_fallo
 ); 
    
    begin
        LOAD_fallo = ( LOAD === LOAD_CHECK )? `BAJO:`ALTO;
    end

endtask


/*
    Recibe la salida rco del contador para determinar si
    el valor es el correcto.
*/
task verificar_rco
(
    input RCO,
    input RCO_check,

    output reg RCO_fallo
);

    begin
        RCO_fallo = ( RCO === RCO_check )? `BAJO:`ALTO;
    end

endtask