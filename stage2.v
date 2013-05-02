`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:28:58 04/08/2013 
// Design Name: 
// Module Name:    stage2 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module stage2(in,out,key,round,ready,done,encrypt,clk,reset);

input [127:0] in,key;
input [3:0]round;
input ready,encrypt,clk,reset;

output [127:0] out;
output done;

reg [127:0] out;
reg done;

reg [3:0]rnd;
reg [127:0]in1,in2;
reg ready1,ready2,encry;

wire [127:0] out1,out2;
wire done1,done2;

sub_stage1  sbs1(in1,out1,ready1,done1,encry,clk,reset);
sub_stage2	sbs2(in2,out2,key,rnd,ready2,done2,encry,clk,reset);

always @(posedge clk)
begin
	if(reset)
	begin
		encry=0;
		ready1=0;
	end
	else if(ready)
	begin
		encry=encrypt;
		in1=in;
		rnd=round;
		ready1=1;
	end
	else
		ready1=0;
end

//*******************************************************************
always @(posedge clk)
begin
	if(reset)
	begin
		ready2=0;
	end
	else if(done1)
	begin
		in2=out1;
		ready2=1;
	end
	else 
		ready2=0;
end

//********************************************************
always @(posedge clk)
begin
	if(reset)
	begin
		done=0;
	end
	else if(done2)
	begin
		out=out2;
		done=1;
	end
	else
		done=0;
end
endmodule 
