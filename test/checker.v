/*
    Tarea 1
    Microelectrónica
    Creado por Jorge Muñoz Taylor
    Carné A53863
    II-2020
*/

/*
    Módulo que se encarga de verificar los resultados provenientes del contador.
*/
module checker #( parameter FILE = "./logs/log.txt" )
(
    input enable, 
    input clk, 
    input reset, 
    input [1:0] mode, 
    input [3:0] D,

    input       load, 
    input       rco, 
    input [3:0] Q
);

    `ifndef TASKS_V
    `include "./test/tasks.v"
    `endif

    integer log;
        
    reg Q_fallo;
    reg rco_fallo;
    reg load_fallo;
    reg enable_reset_fallo;
    reg [3:0] Q_anterior;
    reg continuar;

    initial Q_fallo            = `BAJO;
    initial rco_fallo          = `BAJO;
    initial load_fallo         = `BAJO;
    initial Q_anterior         = `BAJO;
    initial continuar          = `BAJO;
    initial enable_reset_fallo = `BAJO;

    
    initial log = $fopen (FILE); 


    // La señal continuar es una bandera que indica cuando sensar las señales,
    // si es 0 no habrá monitoreo, si es 1 se activará. 
    always @(mode)
    begin
        continuar     = `BAJO;
        #20 continuar = `ALTO;
    end


    // Si la señal de entrada cambia se hace un pequeño retardo para esperar
    // que las señales internas del probador se actualicen. 
    always @(D)
    begin
        if (mode==`CARGA_D && enable!=0 && reset!=1)
        begin
            continuar     = `BAJO;
            #10 continuar = `ALTO;
        end
    end



    /*  */
    always @( enable or reset )
    begin
        Q_anterior = Q_temp;
    end



    reg [3:0] Q_temp;

    /**/
    always @( Q )
    begin

        /* REVISAR LUEGO */
        // Si reset está en alto la salida es 0.
        if ( (reset == `ALTO && enable == `BAJO) || (reset == `ALTO && enable == `ALTO) )
        begin
            Q_anterior = `BAJO;
            Q_temp = Q_anterior;
        end

        else if ( reset == `BAJO && enable == `BAJO )
        begin
            Q_anterior = `HiZ;

        end

        else if ( reset == `BAJO && enable == `ALTO )
        begin
            
            if ( Q_anterior !== 4'bz && Q_anterior !== 4'bx )
            begin

                case (mode)
                
                    `CUENTA_TRES_TRES: Q_anterior = Q_anterior +3;
                    `CUENTA_MENOS_UNO: Q_anterior = Q_anterior -1;
                    `CUENTA_MAS_UNO:   Q_anterior = Q_anterior +1;
                    `CARGA_D:          Q_anterior = D;
                    default:           Q_anterior = `DEFAULT;

                endcase
                
            end

            Q_temp = Q_anterior;

        end // Fin de else if
        

        // Cada flanco positivo se verifican las salidas. 
        // Se verifica la salida Q y se imprime un mensaje si la salida es incorrecta.   

        // Verifica el funcionamiento de la salida Q.
        verificar_Q
        (
            enable, 
            reset, 
            mode, 
            D,
            Q,
            Q_anterior,
            Q_fallo
        );


        // Verifica el funcionamiento de la salida rco.
        verificar_rco
        (
            mode,
            Q,
            Q_anterior,
            rco,
            rco_fallo
        );


        // Los checkers inician luego de 15 tiempos, esto para que se inicien todos
        // los parámetros.
        if ( continuar == `ALTO )
        begin
            // verifica el funcionamiento de la salida LOAD.
            verificar_LOAD
            (
                reset, 
                mode, 
                load,
                load_fallo
            );  
    
        end
        
    end



    always @( Q_fallo )
    begin
        if ( Q_fallo === `ALTO )
        begin
            $display ("tiempo =%2d : modo %1b : Q fail", $time, mode);
            $fdisplay(log, "tiempo =%2d : modo %1b : Q fail", $time, mode);
        end        
    end


    always @( load_fallo )
    begin
        if ( load_fallo === `ALTO )
        begin
            $display ("tiempo =%2d : modo %1b : load fail", $time, mode);
            $fdisplay(log, "tiempo =%2d : modo %1b : load fail", $time, mode);
        end         
    end


    always @( rco_fallo )
    begin
        // Se verifican la salida rco y se imprime un mensaje si la salida es incorrecta.
        if ( rco_fallo === `ALTO )
        begin
            $display  ("tiempo =%2d : modo %1b : rco fail", $time, mode);
            $fdisplay (log, "tiempo =%2d : modo %1b : rco fail", $time, mode);
        end
    end

endmodule