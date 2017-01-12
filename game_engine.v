module Game_Engine(
	clk,
	rst,
	score,
	board,
	x,
	y,
	alive,
	apple_x,
	apple_y
);

input clk;
input rst;
input [255:0] board;
input [3:0] x;
input [3:0] y;

output reg [3:0] score;
output reg [3:0] apple_x;
output reg [3:0] apple_y;
output reg alive;

always @(negedge rst) begin
	if (!rst) begin
		apple_x <= 4'd7;
		apple_y <= 4'd5;
	end
end

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		score <= 4'd0;
	end else begin
		if (x == apple_x && y == apple_y) begin
			// (TODO) how to generate position for the next apple?
			score <= score + 1;
		end
	end
end

endmodule
