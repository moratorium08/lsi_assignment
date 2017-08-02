
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
    reg player_state;

    reg [2:0] board00, board01, board02;
    reg [2:0] board10, board11, board12;
    reg [2:0] board20, board21, board22;


    always @(posedge CLK or negedge RST) begin
        if(!RST) begin
            {red, green, blue} = 3'b111;
        end
        else begin
            {red, green, blue} = 3'b111;
            // show board
            [[w = 10]]
            [[h = 300]]
            [[base = 40]]
            [[for x, y in (0, 0), (100, 0), (200, 0), (300, 0) {
            if(col >= {{ base + x }} && col < {{ base + x + w }} && row >= {{ base + y }} && row < {{base + y + h}}) begin
                    {red, green, blue} = 3'b000;
            end
            }]]
            [[h = 310]]
            [[for x, y in (0, 0), (100, 0), (200, 0), (300, 0) {
            if(row >= {{ base + x }} && row < {{ base + x + w }} && col >= {{ base + y }} && col < {{base + y + h}}) begin
                    {red, green, blue} = 3'b000;
            end
            }]]

            // maru no hyouji
            [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
            if (board{{x}}{{y}} == 2'b1) begin
                if (((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
                    (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) > 1600 &&
                    ((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
                    (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) < 2000) begin
                    {red, green, blue} = 3'b000;
                end
            end
            }]]
            // batsu no hyouji
            [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
            if (board{{x}}{{y}} == 2'b10) begin
                if (((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
                    (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) > 1600 &&
                    ((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
                    (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) < 2000) begin
                    {red, green, blue} = 3'b100;
                end
            end
            }]]

            if(( col + row ) < 195 && (col + row) > 185 && col > 50 && col < 135) begin
                {red, green, blue} = 3'b000;
            end
            if((row - col) < 10 && (col - row) > 10 && col > 50 && col < 135) begin
                {red, green, blue} = 3'b000;
            end
        end
    end

    always @(posedge CLK or negedge RST) begin
        if(!RST) begin
            [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
                board{{x}}{{y}} <= 1'b0;
            }]]
            player_state <= 1'b0;
        end
        else begin
           if (player_state == 1'b0) begin
                if(!board_but00 && board00 == 0) board00 = 2'b1;
                [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
                    else if(!board_but{{x}}{{y}} && board{{x}}{{y}} == 0) begin
                        board{{x}}{{y}} <= 2'b1;
                        player_state <= 1'b1;
                    end
                }]]
            end
            else begin
                if(!board_but00 && board00 == 0) board00 = 2'b1;
                [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
                    else if(!board_but{{x}}{{y}} && board{{x}}{{y}} == 0) begin
                        board{{x}}{{y}} = 2'b1;
                        player_state <= 1'b0;
                    end
                }]]
            end
        end
    end
endmodule
