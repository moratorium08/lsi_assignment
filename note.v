[[basepoint = 45]]
[[for x, y, p, q in eval("[(str(x), str(y), 50 + x*100, 50 + y*100) for x in range(3) for y in range(3)]"){
    `define CENTER{{x}}{{y}}x {{q + basepoint}}
    `define CENTER{{x}}{{y}}y {{p + basepoint}}
}]]

module display(row, col, red, green, blue, board_but00, board_but01, board_but02, board_but10, board_but11,board_but12,board_but20,board_but21,board_but22,vnotactive, CLK, RST);
    input [31:0] row, col;
    input CLK, RST, board_but00, board_but01, board_but02, board_but10, board_but11,board_but12,board_but20,board_but21,board_but22, vnotactive;
    output red, green, blue;
    reg red, green, blue;
    reg player_state;
    reg [1:0] game_state;


    reg [1:0] board00, board01, board02;
    reg [1:0] board10, board11, board12;
    reg [1:0] board20, board21, board22;

    always @(posedge CLK or negedge RST) begin
        if(!RST) begin
            {red, green, blue} = 3'b111;
            [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
                board{{x}}{{y}} <= 2'b00;
            }]]
            player_state = 1'b0;
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
            if (board{{x}}{{y}} == 2'b01) begin
                if (((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
                    (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) > 1600 &&
                    ((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
                    (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) < 2000) begin
                    {red, green, blue} = 3'b000;
                end
            end
            else if (board{{x}}{{y}} == 2'b00) begin
                if (((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
                    (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) > 1600 &&
                    ((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
                    (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) < 2000) begin
                    {red, green, blue} = 3'b100;
                end
            end
            else if (board{{x}}{{y}} == 2'b10) begin
                if (((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
                    (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) > 1600 &&
                    ((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
                    (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) < 2000) begin
                    {red, green, blue} = 3'b010;
                end
            end
            else if (board{{x}}{{y}} == 2'b11) begin
                if (((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
                    (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) > 1600 &&
                    ((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
                    (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) < 2000) begin
                    {red, green, blue} = 3'b001;
                end
            end
            else begin
                if (((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
                    (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) > 1600 &&
                    ((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
                    (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) < 2000) begin
                    {red, green, blue} = 3'b110;
                end
            end
            }]]
            // batsu no hyouji
            [[for x, y, X, c1, Y, c2 in eval("[(str(x), str(y), 45 + 100 * x, 185 + 100 * (x + y), 45, x * 100 - y*100) for x in range(3) for y in range(3)]") {
            if (board{{y}}{{x}} == 2'b10) begin
                if((col + row ) < ({{c1}} + 10'd10) && (col + row) > {{c1}} && col > ({{X}} + 10'd5)  && col < ({{X}} + 10'd90)) begin
                    {red, green, blue} = 3'b000;
                end
                if((row - col + {{c2}}) < 10 && (col - row + {{c2}}) > 10 && col > ({{X}} + 10'd5) && col < ({{X}} + 10'd90)) begin
                    {red, green, blue} = 3'b000;
                end
            end
            }]]
            //!! shinchoku.png : 200,200, 200,200 ]]
           if (player_state == 1'b0) begin
                if(!board_but00 && board00 == 0) begin
                    board00 = 2'b01;
                    player_state = 1'b1;
                end
                [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
                    else if(!board_but{{x}}{{y}} && board{{x}}{{y}} == 2'b00) begin
                        board{{x}}{{y}} = 2'b01;
                        player_state = 1'b1;
                    end
                }]]
            end
            else begin
                if(!board_but00 && board00 == 0) begin
                    board00 = 2'b10;
                    player_state = 1'b0;
                end
                [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
                    else if(!board_but{{x}}{{y}} && board{{x}}{{y}} == 2'b00) begin
                        board{{x}}{{y}} = 2'b10;
                        player_state = 1'b0;
                    end
                }]]
            end
        end
    end
endmodule
