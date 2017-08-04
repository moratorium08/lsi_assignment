{red, green, blue} = 3'b111;
[[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
    board{{x}}{{y}} <= 3'b000;
}]]
player_state = 1'b0;
game_state = 3'b0;
complete_button_action <= 1'b0;
game_config <= 3'b1;
random_number <= 4'b0;
late <= 1'b0;
select_button = 3'b0;
