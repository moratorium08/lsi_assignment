
if (1!=1) begin
end

[[for x in eval("[str(x) for x in range(3)]") {
    else if (board{{x}}0 == 3'b01 && board{{x}}1 == 3'b01 && board{{x}}2 == 3'b01) begin
        game_state <= 3'b10;
    end else if (board{{x}}0 == 3'b10 && board{{x}}1 == 3'b10 && board{{x}}2 == 3'b10) begin
        game_state <= 3'b11;
    end else if (board0{{x}} == 3'b01 && board1{{x}} == 3'b01 && board2{{x}} == 3'b01) begin
        game_state <= 3'b10;
    end else if (board0{{x}} == 3'b10 && board1{{x}} == 3'b10 && board2{{x}} == 3'b10) begin
        game_state <= 3'b11;
    end
}]]
else if (board00 == board11  && board11 == board22) begin
    if (board00 == 3'b01) begin
        game_state <= 3'b10;
    end else if (board00 == 3'b10) begin
        game_state <= 3'b11;
    end
end else if (board20 == board11  && board11 == board02) begin
    if (board11 == 3'b01) begin
        game_state <= 3'b10;
    end else if (board11 == 3'b10) begin
        game_state <= 3'b11;
    end
end else if (game_state == 3'b1 && late == 1'b0) begin
    late <= 1'b1;
end else if (game_state == 3'b1 && late == 1'b1) begin
    if (1==1
    [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
        && board{{x}}{{y}} != 3'b00
    }]]
    ) begin
        game_state <= 3'b100;
    end
end
