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
            game_state = 2'b0;
        end
        else begin
            {red, green, blue} = 3'b111;
            [[import board.v]]
            //!! shinchoku.png : 200,200, 200,200 ]]
            [[import button_action.v]]
        end
    end
endmodule
