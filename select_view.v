[[baseimgx = 25]]
[[for sizex, basey, flag in (512, 100, 0), (740, 200, 1), (480, 300, 2) {
    if (select_button == {{flag}}) begin
        if(col >= {{baseimgx}} && col < {{baseimgx + sizex}}
            && row >= {{basey}}
            && row < ({{basey}} + 100)) begin
                {red, green, blue} <= 3'b001;
        end
    end
}]]
[[!! vs_human.png : 25, 100, 128, 25 : 4]]
[[!! vs_random_ai.png : 25, 200, 185, 25 : 4]]
[[!! vs_my_ai.png : 25, 300, 120, 25 : 4]]
if(!board_fe20) begin
    if (select_button != 2'b10) begin
        select_button <= select_button + 1;
    end
end
else if(!board_fe00) begin
    if (select_button != 2'b0) begin
        select_button <= select_button - 1;
    end
end
else if(!board_fe10) begin
    game_config <= select_button;
    game_state <= 2'b1;
end
