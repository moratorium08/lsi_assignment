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

