`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2020 11:26:46 PM
// Design Name: 
// Module Name: SR
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Shift_Right #(parameter n = 4)
                                    (
                                    input [n-1:0] in,
                                    output [n-1:0] op1,
                                    output [n-1:0] op2,
                                    output [n-1:0] op3,
                                    output [n-1:0] op4,
                                    output reg [n-1:0] result,
                                    input [$clog2(n)-1:0] s
                                    );
       wire zero = 0;
/* ------------------------------------------------------ */
/*                    Stage #1                            */
/* ------------------------------------------------------ */                                   
       mux_2to1 Stage1_lastblock
                     (
                        .in1(in[n-1]),
                        .in2(zero),
                        .s(s[0]),
                        .op(op1[n-1])
                     );
       genvar a;
       for (a=0; a<n-1; a=a+1)
        begin
            mux_2to1 Stage1_Remaining_blocks
                     (
                        .in1(in[a]),
                        .in2(in[a+1]),
                        .s(s[0]),
                        .op(op1[a])
                     );     
        end
/* ------------------------------------------------------ */
/*                    Stage #2                            */
/* ------------------------------------------------------ */ 
       genvar b;
       for (b=n-2; b<n; b=b+1)
        begin
            mux_2to1 Stage2_1st2blocks
                     (
                        .in1(op1[b]),
                        .in2(zero),
                        .s(s[1]),
                        .op(op2[b])
                     );     
        end
       genvar c; 
       for (c=0; c<n-2; c=c+1)
        begin
            mux_2to1 Stage2_Remaining_blocks
                     (
                        .in1(op1[c]),
                        .in2(op1[c+2]),
                        .s(s[1]),
                        .op(op2[c])
                     );     
        end
/* ------------------------------------------------------ */
/*                    Stage #3                            */
/* ------------------------------------------------------ */ 
       genvar d;
       for (d=n-4; d<n; d=d+1)
        begin
            mux_2to1 Stage3_1st4blocks
                     (
                        .in1(op2[d]),
                        .in2(zero),
                        .s(s[2]),
                        .op(op3[d])
                     );     
        end
       genvar e; 
       for (e=0; e<n-4; e=e+1)
        begin
            mux_2to1 Stage3_Remaining_blocks
                     (
                        .in1(op2[e]),
                        .in2(op2[e+4]),
                        .s(s[2]),
                        .op(op3[e])
                     );     
        end 
/* ------------------------------------------------------ */
/*                    Stage #4                            */
/* ------------------------------------------------------ */ 
       genvar f;
       for (f=n-8; d<n; f=f+1)
        begin
            mux_2to1 Stage4_1st8blocks
                     (
                        .in1(op3[f]),
                        .in2(zero),
                        .s(s[3]),
                        .op(op4[f])
                     );     
        end
       genvar g; 
       for (g=0; e<n-8; g=g+1)
        begin
            mux_2to1 Stage4_Remaining_blocks
                     (
                        .in1(op3[g]),
                        .in2(op3[g+4]),
                        .s(s[3]),
                        .op(op4[g])
                     );     
        end
       always @ (*)
        begin
            case (s)
                0 : result = in;
                1 : result = op1;
                2 : result = op2;
                3 : result = op2;
                4 : result = op3;
                5 : result = op3;
                6 : result = op3;
                7 : result = op3;
                8 : result = op4;
                9 : result = op4;
                'hA : result = op4;
                'hB : result = op4;
                'hC : result = op4;
                'hD : result = op4;
                'hE : result = op4;
                'hF : result = op4;
                default : result = in; // default case --> the input will be printed
            endcase        
        end                             
endmodule
