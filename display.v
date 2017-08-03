`define BASEPOINT 10'd45
`define CENTER00x (10'd50 + `BASEPOINT)
`define CENTER01x (10'd150 + `BASEPOINT)
`define CENTER02x (10'd250 + `BASEPOINT)
`define CENTER10x (10'd50 + `BASEPOINT)
`define CENTER11x (10'd150 + `BASEPOINT)
`define CENTER12x (10'd250 + `BASEPOINT)
`define CENTER20x (10'd50 + `BASEPOINT)
`define CENTER21x (10'd150 + `BASEPOINT)
`define CENTER22x (10'd250 + `BASEPOINT)

`define CENTER00y (10'd50 + `BASEPOINT)
`define CENTER01y (10'd50 + `BASEPOINT)
`define CENTER02y (10'd50 + `BASEPOINT)
`define CENTER10y (10'd150 + `BASEPOINT)
`define CENTER11y (10'd150 + `BASEPOINT)
`define CENTER12y (10'd150 + `BASEPOINT)
`define CENTER20y (10'd250 + `BASEPOINT)
`define CENTER21y (10'd250 + `BASEPOINT)
`define CENTER22y (10'd250 + `BASEPOINT)


module display(row, col, red, green, blue, board_but00, board_but01, board_but02, board_but10, board_but11,board_but12,board_but20,board_but21,board_but22,vnotactive, CLK, RST);
	input [31:0] row, col;
	input CLK, RST, board_but00, board_but01, board_but02, board_but10, board_but11,board_but12,board_but20,board_but21,board_but22, vnotactive;
	output red, green, blue;
	reg red, green, blue;
	reg [31:0] originX, originY;
	reg [1:0] key_state;
	reg [9:0] nekoX, nekoY;

	reg player_state;

	reg [2:0] board00, board01, board02;
	reg [2:0] board10, board11, board12;
	reg [2:0] board20, board21, board22;


	always @(posedge CLK or negedge RST) begin
		if(!RST) begin
			red <= 1'b1;
			green <= 1'b1;
			blue <= 1'b1;
		end
		else begin
			if(row >= originY && row < (originY+10'd100) && col >= originX && col < (originX+10'd100)) begin
				red <= 1'b0;
				green <= 1'b0;
				blue <= 1'b1;
			end
			else if (row >= nekoX && row <= (nekoX + 10'd10) &&col >= nekoY && col <= (nekoY + 10'd10)) begin
			    red <= 1'b1;
				 green <= 1'b0;
				 blue <= 1'b1;
		   end
			else begin
				red <= 1'b1;
				green <= 1'b1;
				blue <= 1'b1;
			end
			if(row >= 10'd40 && row < (10'd40+10'd300) &&  col >= 10'd40 && col < (10'd40+10'd10)) begin
				red <= 1'b0;
				green <= 1'b0;
				blue <= 1'b0;
			end
			if(row >= 10'd40 && row < (10'd40+ 10'd300) && col >= 10'd140 && col < (10'd140+10'd10)) begin
				red <= 1'b0;
				green <= 1'b0;
				blue <= 1'b0;
			end
			if(row >= 10'd40 && row < (10'd40+10'd300) &&  col >= 10'd240 && col < (10'd240+10'd10)) begin
				red <= 1'b0;
				green <= 1'b0;
				blue <= 1'b0;
			end
			if(row >= 10'd40 && row < (10'd40+10'd310) &&  col >= 340 && col < (10'd340+10'd10)) begin
				red <= 1'b0;
				green <= 1'b0;
				blue <= 1'b0;
			end
			if(col >= 10'd40 && col < (10'd40+10'd300) &&  row >= 10'd40 && row < (10'd40+10'd10)) begin
				red <= 1'b0;
				green <= 1'b0;
				blue <= 1'b0;
			end
			if(col >= 10'd40 && col < (10'd40+10'd300) && row >= 10'd140 && row < (10'd140+10'd10)) begin
				red <= 1'b0;
				green <= 1'b0;
				blue <= 1'b0;
			end
			if(col >= 10'd40 && col < (10'd40+10'd300) &&  row >= 10'd240 && row < (10'd240+10'd10)) begin
				red <= 1'b0;
				green <= 1'b0;
				blue <= 1'b0;
			end
			if(col >= 10'd40 && col < (10'd40+10'd310) &&  row >= 340 && row < (10'd340+10'd10)) begin
				red <= 1'b0;
				green <= 1'b0;
				blue <= 1'b0;
			end


			if (board00 == 2'b1) begin
				if (((col - `CENTER00x) * (col - `CENTER00x) + (row - `CENTER00y) * (row - `CENTER00y)) > 1600 &&
					((col - `CENTER00x) * (col - `CENTER00x) + (row - `CENTER00y) * (row - `CENTER00y)) < 2000) begin
					red <= 1'b0;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board01 == 2'b1) begin
				if (((col - `CENTER01x) * (col - `CENTER01x) + (row - `CENTER01y) * (row - `CENTER01y)) > 1600 &&
					((col - `CENTER01x) * (col - `CENTER01x) + (row - `CENTER01y) * (row - `CENTER01y)) < 2000) begin
					red <= 1'b0;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board02 == 2'b1) begin
				if (((col - `CENTER02x) * (col - `CENTER02x) + (row - `CENTER02y) * (row - `CENTER02y)) > 1600 &&
					((col - `CENTER02x) * (col - `CENTER02x) + (row - `CENTER02y) * (row - `CENTER02y)) < 2000) begin
					red <= 1'b0;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board10 == 2'b1) begin
				if (((col - `CENTER10x) * (col - `CENTER10x) + (row - `CENTER10y) * (row - `CENTER10y)) > 1600 &&
					((col - `CENTER10x) * (col - `CENTER10x) + (row - `CENTER10y) * (row - `CENTER10y)) < 2000) begin
					red <= 1'b0;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board11 == 2'b1) begin
				if (((col - `CENTER11x) * (col - `CENTER11x) + (row - `CENTER11y) * (row - `CENTER11y)) > 1600 &&
					((col - `CENTER11x) * (col - `CENTER11x) + (row - `CENTER11y) * (row - `CENTER11y)) < 2000) begin
					red <= 1'b0;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board12 == 2'b1) begin
				if (((col - `CENTER12x) * (col - `CENTER12x) + (row - `CENTER12y) * (row - `CENTER12y)) > 1600 &&
					((col - `CENTER12x) * (col - `CENTER12x) + (row - `CENTER12y) * (row - `CENTER12y)) < 2000) begin
					red <= 1'b0;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board20 == 2'b1) begin
				if (((col - `CENTER20x) * (col - `CENTER20x) + (row - `CENTER20y) * (row - `CENTER20y)) > 1600 &&
					((col - `CENTER20x) * (col - `CENTER20x) + (row - `CENTER20y) * (row - `CENTER20y)) < 2000) begin
					red <= 1'b0;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board21 == 2'b1) begin
				if (((col - `CENTER21x) * (col - `CENTER21x) + (row - `CENTER21y) * (row - `CENTER21y)) > 1600 &&
					((col - `CENTER21x) * (col - `CENTER21x) + (row - `CENTER21y) * (row - `CENTER21y)) < 2000) begin
					red <= 1'b0;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board22 == 2'b1) begin
				if (((col - `CENTER22x) * (col - `CENTER22x) + (row - `CENTER22y) * (row - `CENTER22y)) > 1600 &&
					((col - `CENTER22x) * (col - `CENTER22x) + (row - `CENTER22y) * (row - `CENTER22y)) < 2000) begin
					red <= 1'b0;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end

			if (board00 == 2'b10) begin
				if (((col - `CENTER00x) * (col - `CENTER00x) + (row - `CENTER00y) * (row - `CENTER00y)) > 1600 &&
					((col - `CENTER00x) * (col - `CENTER00x) + (row - `CENTER00y) * (row - `CENTER00y)) < 2000) begin
					red <= 1'b1;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board01 == 2'b10) begin
				if (((col - `CENTER01x) * (col - `CENTER01x) + (row - `CENTER01y) * (row - `CENTER01y)) > 1600 &&
					((col - `CENTER01x) * (col - `CENTER01x) + (row - `CENTER01y) * (row - `CENTER01y)) < 2000) begin
					red <= 1'b1;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board02 == 2'b10) begin
				if (((col - `CENTER02x) * (col - `CENTER02x) + (row - `CENTER02y) * (row - `CENTER02y)) > 1600 &&
					((col - `CENTER02x) * (col - `CENTER02x) + (row - `CENTER02y) * (row - `CENTER02y)) < 2000) begin
					red <= 1'b1;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board10 == 2'b10) begin
				if (((col - `CENTER10x) * (col - `CENTER10x) + (row - `CENTER10y) * (row - `CENTER10y)) > 1600 &&
					((col - `CENTER10x) * (col - `CENTER10x) + (row - `CENTER10y) * (row - `CENTER10y)) < 2000) begin
					red <= 1'b0;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board11 == 2'b10) begin
				if (((col - `CENTER11x) * (col - `CENTER11x) + (row - `CENTER11y) * (row - `CENTER11y)) > 1600 &&
					((col - `CENTER11x) * (col - `CENTER11x) + (row - `CENTER11y) * (row - `CENTER11y)) < 2000) begin
					red <= 1'b0;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board12 == 2'b10) begin
				if (((col - `CENTER12x) * (col - `CENTER12x) + (row - `CENTER12y) * (row - `CENTER12y)) > 1600 &&
					((col - `CENTER12x) * (col - `CENTER12x) + (row - `CENTER12y) * (row - `CENTER12y)) < 2000) begin
					red <= 1'b0;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board20 == 2'b10) begin
				if (((col - `CENTER20x) * (col - `CENTER20x) + (row - `CENTER20y) * (row - `CENTER20y)) > 1600 &&
					((col - `CENTER20x) * (col - `CENTER20x) + (row - `CENTER20y) * (row - `CENTER20y)) < 2000) begin
					red <= 1'b0;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board21 == 2'b10) begin
				if (((col - `CENTER21x) * (col - `CENTER21x) + (row - `CENTER21y) * (row - `CENTER21y)) > 1600 &&
					((col - `CENTER21x) * (col - `CENTER21x) + (row - `CENTER21y) * (row - `CENTER21y)) < 2000) begin
					red <= 1'b0;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end
			if (board22 == 2'b10) begin
				if (((col - `CENTER22x) * (col - `CENTER22x) + (row - `CENTER22y) * (row - `CENTER22y)) > 1600 &&
					((col - `CENTER22x) * (col - `CENTER22x) + (row - `CENTER22y) * (row - `CENTER22y)) < 2000) begin
					red <= 1'b0;
					green <= 1'b0;
					blue <= 1'b0;
				end
			end


			if(( col + row ) < 195 && (col + row) > 185 && col > 50 && col < 135) begin
				red <= 1'b0;
				green <= 1'b0;
				blue <= 1'b0;
			end
			if((row - col) < 10 && (col - row) > 10 && col > 50 && col < 135) begin
				red <= 1'b0;
				green <= 1'b0;
				blue <= 1'b0;
			end
		end
	end

	always @(posedge CLK or negedge RST) begin
		if(!RST) begin
			originX <= 10'd300;
			originY <= 10'd200;
			nekoX <= 10'd100;
			nekoY <= 10'd50;
			key_state <= 2'd0;
			board00 <= 1'b0;
			board01 <= 1'b0;
			board02 <= 1'b0;
			board10 <= 1'b0;
			board11 <= 1'b0;
			board12 <= 1'b0;
			board20 <= 1'b0;
			board21 <= 1'b0;
			board22 <= 1'b0;
			player_state <= 1'b0;

		end
		else begin
			case(key_state)
				2'd0: begin
					if(vnotactive) key_state <= 2'd1;
				end
				2'd1: begin
				   if (player_state == 1'b0) begin
						if(!board_but00 && board00 == 0) board00 = 2'b1;
						if(!board_but01 && board01 == 0) board01 = 2'b1;
						if(!board_but02 && board02 == 0) board02 = 2'b1;
						if(!board_but10 && board10 == 0) board10 = 2'b1;
						if(!board_but11 && board11 == 0) board11 = 2'b1;
						if(!board_but12 && board12 == 0) board12 = 2'b1;
						if(!board_but20 && board20 == 0) board20 = 2'b1;
						if(!board_but21 && board21 == 0) board21 = 2'b1;
						if(!board_but22 && board22 == 0) board22 = 2'b1;
					end
					else begin
						if(!board_but00 && board00 == 0) board00 = 2'b10;
						if(!board_but01 && board01 == 0) board01 = 2'b10;
						if(!board_but02 && board02 == 0) board02 = 2'b10;
						if(!board_but10 && board10 == 0) board10 = 2'b10;
						if(!board_but11 && board11 == 0) board11 = 2'b10;
						if(!board_but12 && board12 == 0) board12 = 2'b10;
						if(!board_but20 && board20 == 0) board20 = 2'b10;
						if(!board_but21 && board21 == 0) board21 = 2'b10;
						if(!board_but22 && board22 == 0) board22 = 2'b10;
					end
					if (!board_but00 || !board_but01 || !board_but02 ||
					    !board_but10 || !board_but11 || !board_but12 ||
						 !board_but20 || !board_but21 || !board_but22) begin
						 player_state = player_state ^ 1'b1;
					end

				end
				2'd2: begin
					if(!vnotactive) key_state <= 2'd0;
				end
				2'd3: begin
				end
			endcase
		end
	end
endmodule
