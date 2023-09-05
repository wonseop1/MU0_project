`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/22 17:15:07
// Design Name: 
// Module Name: mem_model
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

module mem_model (clk, addr, data, memrq, rnw);
input clk, memrq, rnw;
input [11:0] addr;
inout [15:0] data;
reg [15:0] mem [4095:0];
assign data = memrq & rnw ? mem[addr] : 16'hz; // read
always @(negedge clk) // write
if (memrq & !rnw) mem[addr] <= data;
initial begin
mem[0] = {`LDA, 12'h64}; // program codes start
mem[1] = {`SUB, 12'h65};
mem[2] = {`JNE, 12'h6 };
mem[3] = {`LDA, 12'h64};
mem[4] = {`ADD, 12'h65};
mem[5] = {`JMP, 12'h9 };
mem[6] = {`LDA, 12'h64};
mem[7] = {`SUB, 12'h66};
mem[8] = {`SUB, 12'h66};
mem[9] = {`STO, 12'h64};
mem[10] = {`STP, 12'h0};
mem['h64] = 16'h4444; // program data start
mem['h65] = 16'h2222;
mem['h66] = 16'h1111;
end
endmodule