
/*
    Tarea 1
    Microelectrónica
    Creado por Jorge Muñoz Taylor
    Carné A53863
    II-2020
*/

`timescale 1ns / 1ps


// Entrada A
// Salida Y
module NOT
(
  input  A, 
  output Y
);

  specify

    specparam t_pdh = 6.3;
    specparam t_pdl = 5.5;

    (A => Y) = (t_pdh, t_pdl);

  endspecify

  assign Y = ~A;

endmodule


// Entrada A, B
// Salida Y
module NAND_2
(
  input  A, 
  input  B, 
  output Y
);

  specify
    // t_pdh = t_phl = 9ns
    specparam t_pd = 9;

    (A, B *> Y) = t_pd;

  endspecify

  assign Y = ~(A & B);

endmodule


// Entrada A, B
// Salida Y
module NAND_3
(
  input  A, 
  input  B,
  input  C, 
  output Y
);

  specify
    specparam t_pdh = 10;
    specparam t_pdl = 9.5;
    
    (A, B, C *> Y) = (t_pdh, t_pdl);

  endspecify

  assign Y = ~( A & B & C);

endmodule


// Entrada A, B
// Salida Y
module NOR_2
( 
  input  A, 
  input  B,  
  output Y
);

  specify
    specparam t_pdh = 8;
    specparam t_pdl = 7;

    (A, B *> Y) = (t_pdh, t_pdl);

  endspecify

  assign Y = ~(A|B);

endmodule


// Entrada A, B
// Salida Y
module NOR_3
(
  input  A, 
  input  B, 
  input  C, 
  output Y
);

  specify
    //t_pdh = t_pdl = 9ns
    specparam t_pd = 9;
    
    (A, B, C *> Y) = t_pd;

  endspecify

  assign Y = ~(A|B|C);

endmodule


// Entrada D
// Reloj C
// Salida Q
module DFF
(
  input  C, 
  input  D, 
  output reg Q
);

  specify 
    // t_pdh = t_pdl = 3.8 = t_pd
    specparam t_pd = 3.8;
    specparam t_su = 1.1;
    specparam t_ho = 0.4;

    $setup ( D, posedge C, t_su );
    $hold  ( posedge C, D, t_ho );

    ( D => Q ) = t_pd;
  endspecify

  always @(posedge C)
    Q <= D;
  
endmodule
