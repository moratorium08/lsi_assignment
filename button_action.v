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
end
else begin
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
end
