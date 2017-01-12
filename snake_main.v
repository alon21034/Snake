module Snake_Main(
  clk, rst, out, control, x, y
);

input clk;
input rst;
input[1:0] control;

output reg[15:0] out;

reg[1:0] state;
reg[1:0] next_state;

output reg[3:0] x;
output reg[3:0] y;

always @(*) begin
    // (TODO) no U-turn.
	next_state = control;
end

always @(negedge rst) begin
	if (!rst) begin
		x <= 4'd2;
		y <= 4'd3;
	end
end

always @(negedge clk or negedge rst) begin
    if (!rst) begin
        state <= 2'd0;
    end else begin
		state <= next_state;
    end
end

always @(negedge clk or negedge rst) begin
    if (!rst) begin
        x <= 4'd2;
        y <= 4'd3;
    end else begin
		case(state)
		2'd0: begin
			x <= x;
			y <= y+1;
		end
		2'd1: begin
			x <= x;
			y <= y-1;
		end
		2'd2: begin
			x <= x-1;
			y <= y;
		end
		2'd3: begin
			x <= x+1;
			y <= y;
		end
		default: begin
			x <= x;
			y <= y;
		end
		endcase    
	end
end

endmodule
