module Display_Module(
    clk, rst, x, y, board, score, apple_x, apple_y
);

input clk;
input rst;
input [15:0] x;
input [15:0] y;
input [255:0] board;
input [3:0] score;
input [3:0] apple_x;
input [3:0] apple_y;

reg [15:0] counter;

integer i, j;

reg [127:0] str = "xxxxxxxxxxxxxxxx";

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		counter <= 15'd0;
	end else begin
		counter <= counter + 15'd1;
	end
end

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		$display("reset...");
		$display("Game Start!");
	end else begin
		$display("counter: %d", counter);
		$display("score: %d", score);
		$display("x: %x y: %x", x, y);
        for (i=0 ; i<16; i=i+1) begin
			for (j=0; j<16 ; j=j+1) begin
				// (TODO) need a better impletation...
				if (i == x[3:0] && j == y[3:0]) begin
					str = str << 8 | 8'd35;
				end else if (i == x[7:4] && j == y[7:4]) begin
					str = str << 8 | 8'd35;
				end else if (i == x[11:8] && j == y[11:8]) begin
					str = str << 8 | 8'd35;
				end else if (i == x[15:12] && j == y[15:12]) begin
					str = str << 8 | 8'd35;
				end else begin
					str = str << 8 | 8'd46;
				end

				if (i == apple_x && j == apple_y && str[7:0] != 8'd35) begin
					str = {str[127:8], 8'd111};
				end

				if (board[i*16+j] == 1'b1) begin
					str = {str[127:8], 8'd120}; 
				end
			end
			$display("%s", str);
		end
	end
end


endmodule
