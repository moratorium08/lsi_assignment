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
    reg [2:0] game_state;
    reg [2:0] game_config;
    reg [3:0] random_number;

    reg late;

    reg [1:0] board00, board01, board02;
    reg [1:0] board10, board11, board12;
    reg [1:0] board20, board21, board22;
    reg complete_button_action;

    [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
        reg board_but_d1{{x}}{{y}}, board_but_d2{{x}}{{y}}, board_but_d3{{x}}{{y}};
    }]]

    [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
        always @(posedge CLK or negedge RST) begin
            if (!RST) begin
                board_but_d1{{x}}{{y}} <= 1'b0;
                board_but_d2{{x}}{{y}} <= 1'b0;
                board_but_d3{{x}}{{y}} <= 1'b0;
            end else begin
                board_but_d1{{x}}{{y}} <= board_but{{x}}{{y}};
                board_but_d2{{x}}{{y}} <= board_but_d1{{x}}{{y}};
                board_but_d3{{x}}{{y}} <= board_but_d2{{x}}{{y}};
            end
        end
        assign board_fe{{x}}{{y}} = ~(~board_but_d2{{x}}{{y}} & board_but_d3{{x}}{{y}});
    }]]

    always @(posedge CLK or negedge RST) begin
        if(!RST) begin
            {red, green, blue} = 3'b111;
            [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
                board{{x}}{{y}} <= 2'b00;
            }]]
            player_state = 1'b0;
            game_state = 3'b0;
            complete_button_action <= 1'b0;
            game_config <= 3'b1;
            random_number <= 4'b0;
            late <= 1'b0;
        end
        else begin
            {red, green, blue} = 3'b111;
            random_number <= random_number + 4'b1;
            if (random_number > 4'd8) begin
                random_number <= 4'b0;
            end
            [[import board.v]]

            if (game_state == 2'b0) begin
                game_state <= 2'b1;
            end
            else if (game_state == 2'b1) begin
                complete_button_action <= 1'b0;
                [[import button_action.v]]
                if(complete_button_action == 1'b0) begin
                    [[import judge_board.v]]
                end
                else begin
                    [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
                        if ((board{{x}}{{y}} != 2'b00) &&
                           (board{{x}}{{y}} != 2'b01) &&
                           (board{{x}}{{y}} != 2'b10) &&
                           (board{{x}}{{y}} != 2'b11)) begin
                           board{{x}}{{y}} = 2'b00;
                           player_state = player_state ^ 1'b1;
                        end
                    }]]
                end
                //!! shinchoku.png : 100, 100, 200, 200 : 1]]
            end else if (game_state == 2'b10) begin
                [[!! win.png : 400, 400, 100, 40 : 1]]
            end else if (game_state == 2'b11) begin
                [[!! lose.png : 400, 400, 100, 40 : 1]]
            end else if (game_state == 3'b100) begin
                [[!! draw.png : 400, 400, 100, 40 : 1]]
            end
        end
    end
endmodule
