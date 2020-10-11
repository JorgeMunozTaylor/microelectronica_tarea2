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
    input enable, 
    input reset, 
    input [1:0] mode, 
    input [3:0] D,
    input [3:0] Q,
    input [3:0] Q_anterior,
    
    output reg Q_fallo //Si es 1 indica que Q falló la prueba. 
); 
    integer temp;

    begin     
     
        /**/
        if ( enable === `ACTIVO && reset === `DESACTIVADO )
        begin 
            Q_fallo = ( Q === Q_anterior )? `BAJO:`ALTO;                
        end
  
    end

endtask


/*
    Recibe la salida load del contador para determinar si
    el valor es el correcto.
*/
task verificar_LOAD
(
    //input enable, 
    input reset, 
    input [1:0] mode, 
    input load,

    output reg load_fallo //Si es 1 indica que load falló la prueba.
 ); 
    begin

        if (  mode === `CARGA_D && reset === `DESACTIVADO && load != `ALTO )
        begin
            load_fallo = `ALTO;            
        end

        else
            load_fallo = `BAJO;

    end

endtask


/*
    Recibe la salida rco del contador para determinar si
    el valor es el correcto.
*/
task verificar_rco
(
    input [3:0] mode,
    input [3:0] Q,
    input [3:0] Q_anterior,
    input rco,

    output reg rco_fallo //Si es 1 indica que rco falló la prueba.
);
    begin

        /* Si reset es 1 o reset=enable=0 el RCO debe ser 0 */
        if ( ( reset == `BAJO && enable == `ALTO ) ) 
        begin

            if (mode == `CARGA_D)
            begin
                if (rco != `BAJO) rco_fallo = `ALTO;
                else rco_fallo = `BAJO;
            end

            else
            begin
                if ( Q === 4'h0 && (Q_anterior -1) === (Q - 1) && mode == `CUENTA_MAS_UNO )
                begin
                    rco_fallo <= ( rco !== `ALTO )? `ALTO:`BAJO;
                end

                else if ( Q === 4'hf && (Q_anterior -1) === (Q-1) && mode == `CUENTA_MENOS_UNO )
                begin
                    rco_fallo <= ( rco !== `ALTO )? `ALTO:`BAJO;
                end

                else if ( Q === 4'h0 && (Q_anterior - 3) === (Q - 3) && mode == `CUENTA_TRES_TRES )
                begin
                    rco_fallo <= ( rco !== `ALTO )? `ALTO:`BAJO;
                end

                else if ( Q === 4'h1 && (Q_anterior - 3) === (Q - 3) && mode == `CUENTA_TRES_TRES )
                begin
                    rco_fallo <= ( rco !== `ALTO )? `ALTO:`BAJO;
                end

                else if ( Q === 4'h2 && (Q_anterior - 3) === (Q - 3) && mode == `CUENTA_TRES_TRES )
                begin
                    rco_fallo <= ( rco !== `ALTO )? `ALTO:`BAJO;
                end

                else
                begin
                    rco_fallo <= ( rco !== `ALTO && rco !== `HiZ && rco !== 1'bx )? `BAJO:`ALTO;
                end

            end
        end

        else
        begin
            rco_fallo <= ( rco === `BAJO )? `BAJO:`ALTO;
        end

    end

endtask