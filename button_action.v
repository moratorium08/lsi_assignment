if (player_state == 1'b0) begin
    if(1!=1) begin
    end
    [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
        else if(!board_fe{{x}}{{y}} && board{{x}}{{y}} == 2'b00) begin
            board{{x}}{{y}} <= 2'b01;
            player_state <= 1'b1;
        end
    }]]
end else begin
    if (game_config == 3'b0) begin
        if(1!=1) begin
        end
        [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
            else if(!board_fe{{x}}{{y}} && board{{x}}{{y}} == 3'b00) begin
                board{{x}}{{y}} <= 2'b10;
                player_state <= 1'b0;
            end
        }]]
    end else if (game_config == 3'b1) begin
        [[import random_ai.v]]
    end else if (game_config == 3'b10) begin
        if (next_put != 9'd9) begin
            if (1!=1) begin
            end
            [[for x, y, i in eval("[(str(x), str(y), str(3 * x + y)) for x in range(3) for y in range(3)]") {
                else if (9'd{{i}}==next_put) begin
                    board{{x}}{{y}} <= 2'b10;
                end
            }]]
            player_state <= 1'b0;
            cnt <= 9'b0;
            see <= 9'b0;
            my_turn <= 5'd2;
            current_winner <= 9'd8;
            next_put <= 9'd9;
            winner <= 9'd0;

            put[0] <= 9;
            put[1] <= 9;
            put[2] <= 9;
            put[3] <= 9;
            put[4] <= 9;
            put[5] <= 9;
            put[6] <= 9;
            put[7] <= 9;
            put[8] <= 9;

            draw_put[0] <= 9;
            draw_put[1] <= 9;
            draw_put[2] <= 9;
            draw_put[3] <= 9;
            draw_put[4] <= 9;
            draw_put[5] <= 9;
            draw_put[6] <= 9;
            draw_put[7] <= 9;
            draw_put[8] <= 9;

            search <= 1'b0;
        end else begin
            [[import my_ai.v]]
            search <= 1'b1;
        end
        if (cnt > 8 || cnt < 0) begin
            blue <= 1;
        end
        if (!(my_turn == 5'd2 || my_turn == 5'd1)) begin
            green <= 1;
        end
        if(!(current_winner == 8 || current_winner <= 3) ) begin
            blue <= 1;
            green <= 1;
        end
        if(see > 8 || see < 0) begin
            red <= 1;
        end
    end
end
