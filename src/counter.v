/*
    Tarea 2
    Microelectrónica
    Creado por Jorge Muñoz Taylor
    Carné A53863
    II-2020
*/


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

    reg [3:0] Q_temp = `BAJO; // Guarda el valor anterior de Q
    reg EN_RE;                // Si es 1:  ENABLE = RESET = 0



    /**/
    always @( posedge CLK )
    begin

        if ( EN_RE == `BAJO )
        begin
            /* Si ENABLE es 1 el contador funciona normal */
            if ( ENABLE == `ALTO )
            begin
                
                if( Q !== 4'bz && Q !== 4'bx ) 
                    Q_temp = Q;

                case (MODO)

                    `CUENTA_TRES_TRES: {RCO, Q} = Q_temp +3;
                    `CUENTA_MENOS_UNO: {RCO, Q} = Q_temp -1;
                    `CUENTA_MAS_UNO:   {RCO, Q} = Q_temp +1;
                    `CARGA_D:          {RCO, Q} = {`BAJO, D};
                    default:           {RCO, Q} = `DEFAULT;

                endcase
                
            end
            /* Si ENABLE es 0 el contador permanece en el ultimo estado */
        end




        /* Si RESET es 1 todas las salidas se ponen en 0 */
        if ( RESET == `ALTO )
        begin
            EN_RE <= `BAJO;
            Q     <= `BAJO;
            RCO   <= `BAJO;
        end

        /* Si ENABLE es 0 y RESET es 0 la salida Q es Hiz */
        else 
        begin

            if ( ENABLE == `BAJO )
            begin
                if (EN_RE == `BAJO) Q_temp = Q;
                EN_RE  = `ALTO;
                Q      = `HiZ;
            end

            else
            begin

                if( EN_RE == `ALTO )
                    EN_RE <= `BAJO;
            end

        end




        /* Si se esta en modo CARGA la salida LOAD es 1, 0 en caso contrario */
        if ( MODO === `CARGA_D && (RESET === 0 ) ) 
            LOAD = `ALTO;
        else
            LOAD = `BAJO;

    end // Always end

endmodule