if (player_state == 1'b0) begin
    if(!board_fe00&& board00 == 0) begin
        board00 = 2'b01;
        player_state = 1'b1;
        complete_button_action <= 1'b1;
    end
    [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
        else if(!board_fe{{x}}{{y}} && board{{x}}{{y}} == 2'b00) begin
            board{{x}}{{y}} = 2'b01;
            player_state = 1'b1;
            complete_button_action <= 1'b1;
        end
    }]]
end else begin
    if (game_config == 3'b0) begin
        if(!board_fe00 && board00 == 0) begin
            board00 = 2'b10;
            player_state = 1'b0;
            complete_button_action <= 1'b1;
        end
        [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
            else if(!board_fe{{x}}{{y}} && board{{x}}{{y}} == 2'b00) begin
                board{{x}}{{y}} = 2'b10;
                player_state = 1'b0;
                complete_button_action <= 1'b1;
            end
        }]]
    end else if (game_config == 3'b1) begin
        [[import random_ai.v]]
    end else if (game_config == 3'b10) begin
        if (next_put != 9) begin
            [[for x, y, i in eval("[(str(x), str(y), 3 * x + y) for x in range(3) for y in range(3)]") {
                if ({{i}}==next_put) begin
                    board{{x}}{{y}} = 2'b10;
                end
            }]]
            cnt = 9'b0;
            see = 9'b0;
            my_turn = 5'd2;
            cnt = 9'b0;
            current_winner = 9'd8;
            next_put = 9'd9;
            winner = 9'd8;

            put[0] = 9;
            put[1] = 9;
            put[2] = 9;
            put[3] = 9;
            put[4] = 9;
            put[5] = 9;
            put[6] = 9;
            put[7] = 9;
            put[8] = 9;

            draw_put[0] = 9;
            draw_put[1] = 9;
            draw_put[2] = 9;
            draw_put[3] = 9;
            draw_put[4] = 9;
            draw_put[5] = 9;
            draw_put[6] = 9;
            draw_put[7] = 9;
            draw_put[8] = 9;

            player_state = 1'b0;
        end else begin
            [[import my_ai.v]]
        end
    end
end
