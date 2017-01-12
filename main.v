`timescale 1ns/10ps
`define CYCLE 2 

`include "snake_main.v"
`include "display.v"
`include "extend.v"
`include "game_engine.v"

module Main;

// reg and wire
reg clk;
reg rst;
reg[1:0] control;

wire[15:0] data;
wire[3:0] x;
wire[3:0] y;
// clock
always begin #(`CYCLE/2) clk <= ~clk; end

// 
initial begin clk = 1'b0; end

// Modules
Snake_Main snake_main(
  .clk(clk),
  .rst(rst),
  .out(data),
  .control(control),
  .x(x),
  .y(y)
);

Snake_Extend snake_extend(
  .clk(clk),
  .rst(rst),
  .x(x),
  .y(y),
  .len(score),
  .out_x(out_x),
  .out_y(out_y)
);

Display_Module display_module(
  .clk(clk),
  .rst(rst),
  .x(out_x),
  .y(out_y),
  .board(board),
  .score(score),
  .apple_x(apple_x),
  .apple_y(apple_y)
);

Game_Engine game_engine(
  .clk(clk),
  .rst(rst),
  .score(score),
  .board(board),
  .x(x),
  .y(y),
  .alive(alive),
  .apple_x(apple_x),
  .apple_y(apple_y)
);


reg [255:0] board;

wire [15:0] out_x;
wire [15:0] out_y;
wire [3:0] score;
wire [3:0] apple_x;
wire [3:0] apple_y;

initial begin
    board = 256'h_ffff_8001_8001_8001_8001_8001_8001_8001_8001_8001_8001_8001_8001_8001_8001_ffff;

end

initial begin
 $dumpfile("output.vcd");
 $dumpvars;
end

// testbench
initial begin
 clk = 1'b0;
 rst = 1'b1;
 control = 2'b0;

 #2 rst = 1'b0;
 #1 begin rst = 1'b1; control = 2'd0; end
 #3 begin control = 2'd3; end
 // #13 control = 2'd1;
 // #15 control = 2'd2;
 // #18 control = 2'd1;

 #30 $finish;
end

endmodule
