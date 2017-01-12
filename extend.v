module Snake_Extend(
	clk,
	rst,
	len,
	x,
	y,
	out_x,
	out_y,
);

input clk;
input rst;

input [3:0] len;
input [3:0] x;
input [3:0] y;

output reg [15:0] out_x;
output reg [15:0] out_y;

reg [15:0] mask;

integer i;

always @(*) begin
	case(len)
	4'd0: mask = 16'hf;
	4'd1: mask = 16'hff;
	4'd2: mask = 16'hfff;
	4'd3: mask = 16'hffff;
	endcase
end


always @(posedge clk or negedge rst) begin
	if (!rst) begin
		out_x <= 8'd0;
		out_y <= 8'd0;
	end else begin
		out_x <= {out_x[11:0], x} & mask;
		out_y <= {out_y[11:0], y} & mask;
	end
end

endmodule
