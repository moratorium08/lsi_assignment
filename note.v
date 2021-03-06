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
    reg [2:0] select_button;

    reg late;
    reg late2;
    reg late3;
    reg search;
    reg red_flag;
    reg hanabi_state;

    reg [8:0] put[0:9];
    reg [8:0] draw_put[0:9];

    reg [8:0] cnt;
    reg [8:0] see;
    reg [8:0] my_turn;
    reg [8:0] current_winner;
    reg [8:0] next_put;
    reg [8:0] winner;


    reg [2:0] board00, board01, board02;
    reg [2:0] board10, board11, board12;
    reg [2:0] board20, board21, board22;

    reg [31:0] centerx;
    reg [31:0] centery;
    reg [31:0] timing;
    reg [31:0] timing2;

    reg [31:0] pointersx[19:0];
    reg [31:0] pointersy[19:0];
    reg [31:0] velocitysx[19:0];
    reg [31:0] velocitysy[19:0];

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
            [[import initialize.v]]
        end
        else begin
            {red, green, blue} <= 3'b111;
            timing <= timing + 1;
            if (timing == 400000) begin
                timing <= 0;
                if (hanabi_state == 1'b1) begin
                    if (timing2 == 10) begin
                        [[for i, x in eval("[(str(x), x) for x in range(20)]") {
                            velocitysy[{{i}}] <= velocitysy[{{i}}] + 1;
                        }]]
                        [[for i, x in eval("[(str(x), x) for x in range(20)]") {
                            pointersx[{{i}}] <= pointersx[{{i}}] + velocitysx[{{i}}];
                        }]]
                        [[for i, x in eval("[(str(x), x) for x in range(20)]") {
                            pointersy[{{i}}] <= pointersy[{{i}}] + velocitysy[{{i}}];
                        }]]
                    end
                end
                else begin
                    //centerx <= centerx + 1;
                    centery <= centery - 10;
                    if (centery < 200) begin
                        hanabi_state <= 1;
                    end
                end
            end
            if (((col - centerx) * (col - centerx) +
                (row - centery) * (row - centery)) < 400) begin
                {red, green, blue} <= 3'b100;
            end
            [[for i, x in eval("[(str(x), x) for x in range(20)]") {
                if (((col - pointersx[{{i}}]) * (col - pointersx[{{i}}]) +
                    (row - pointersy[{{i}}]) * (row - pointersy[{{i}}])) < 100) begin
                    {red, green, blue} <= 3'b100;
                end
            }]]
            random_number <= random_number + 4'b1;
            if (random_number > 4'd8) begin
                random_number <= 4'b0;
            end

            if (game_state == 3'b0) begin
                [[import select_view.v]]
            end
            else begin
                [[import board.v]]
                if (game_state == 3'b1) begin
                    [[import button_action.v]]
                    if (search == 1'b0) begin
                        [[import judge_board.v]]
                    end
                    //!! shinchoku.png : 100, 100, 200, 200 : 1]]
                end else if (game_state == 3'b10) begin
                    //!! win.png : 400, 400, 100, 40 : 1]]
                end else if (game_state == 3'b11) begin
                    //!! lose.png : 400, 400, 100, 40 : 1]]
                end else if (game_state == 3'b100) begin
                    //!! draw.png : 400, 400, 100, 40 : 1]]
                end
                if (red_flag ==1'b1) begin
                    red <= 1;
                end
            end
        end
    end
endmodule
