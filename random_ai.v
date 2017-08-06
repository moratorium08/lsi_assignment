if (random_number == 0 && board00 == 0) begin
    board00 <= 2'b10;
    player_state <= 1'b0;
    complete_button_action <= 1'b1;
end
[[for x, y, z in eval("[(str(x), str(y), str(3*x + y)) for x in range(3) for y in range(3)]"){
    if (random_number == {{z}} && board{{x}}{{y}} == 0) begin
        board{{x}}{{y}} <= 2'b10;
        player_state <= 1'b0;
        complete_button_action <= 1'b1;
    end
}]]
