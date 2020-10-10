/*
    Tarea 2
    Microelectrónica
    Creado por Jorge Muñoz Taylor
    Carné A53863
    II-2020
*/

`ifndef DEFINES_V
`include "./src/defines.v"
`endif

/*
Descripción conductual de un contador que cuenta con 4 modos de operación: 

1. Cuenta ascendente de 3 en 3.
2. Cuenta descendente de 1 en 1.
3. Cuenta ascendente de 1 en 1.
4. Carga la entrada D en Q.
*/
module counter 
(
    input            CLK,
    input            ENABLE,
    input            RESET,
    input      [3:0] D,
    input      [1:0] MODO,

    output reg [3:0] Q,
    output reg       RCO,
    output reg       LOAD
);

    /* Indica si Q está en alta impedancia 

        temp == 1: Q vale zzzz
        temp == 0: Q es diferente de zzzz
    */
    reg temp = `BAJO; 

    /* Loop principal activado por el flanco positivo de CLK */
    always @( posedge CLK )
    begin

            /* Si ENABLE es 1 el contador funciona normal */
            if ( ENABLE == `ALTO && RESET == `BAJO )
            begin
                
                /* Si temp = 1 (es decir Q==zzzz) se resetean Q y RCO */
                if ( temp == `ALTO )
                begin
                    Q    <= `DEFAULT;
                    temp <= `BAJO;
                    RCO  <= `BAJO;
                end
                
                else
                begin
                    /* Como Q no esta en alta impedancia el contador funciona
                    normal */
                    case (MODO)

                        `CUENTA_TRES_TRES: {RCO, Q} <= Q + 3;
                        `CUENTA_MENOS_UNO: {RCO, Q} <= Q - 1;
                        `CUENTA_MAS_UNO:   {RCO, Q} <= Q + 1;
                        `CARGA_D:          {RCO, Q} <= {`BAJO, D};
                        default:           {RCO, Q} <= `DEFAULT;

                    endcase
                    

                    /* Si se esta en modo CARGA la salida LOAD es 1, 0 en caso contrario */
                    if ( MODO == `CARGA_D ) 
                        LOAD <= `ALTO;
                    else
                        LOAD <= `BAJO; 

                end

            end
                
            /* Si enable=reset=0 la salida Q = zzzz y las demas salidas se
            ponen en bajo, este estado se indica con la variable temp en alto */
            else if ( ENABLE == `BAJO && RESET == `BAJO )
            begin
                Q    <= `HiZ;
                RCO  <= `BAJO;
                LOAD <= `BAJO;
                temp <= `ALTO;
            end

            /* Como el reset=1 todas las salidas se ponen en bajo */
            else if ( ENABLE == `ALTO && RESET == `ALTO )
            begin
                Q    <= `BAJO;
                RCO  <= `BAJO;
                LOAD <= `BAJO; 
                temp <= `BAJO;  
            end

            /* Como el reset=1 todas las salidas se ponen en bajo */ 
            else
            begin
                Q    <= `BAJO;
                RCO  <= `BAJO;
                LOAD <= `BAJO; 
                temp <= `BAJO;               
            end

    end // Always end

endmodule