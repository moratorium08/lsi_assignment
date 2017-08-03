
[[for x in eval("[str(x) for x in range(3)]") {
    if (board{{x}}0 == 2'b01 && board{{x}}1 == 2'b01 && board{{x}}2 == 2'b01) begin
        game_state <= 2'b10;
    end else if (board{{x}}0 == 2'b10 && board{{x}}1 == 2'b10 && board{{x}}2 == 2'b10) begin
        game_state <= 2'b11;
    end else if (board0{{x}} == 2'b01 && board1{{x}} == 2'b01 && board2{{x}} == 2'b01) begin
        game_state <= 2'b10;
    end else if (board0{{x}} == 2'b10 && board1{{x}} == 2'b10 && board2{{x}} == 2'b10) begin
        game_state <= 2'b11;
    end
}]]
if (board00 == board11  && board11 == board22) begin
    if (board00 == 2'b01) begin
        game_state <= 2'b10;
    end else if (board00 == 2'b10) begin
        game_state <= 2'b11;
    end
end else if (board20 == board11  && board11 == board02) begin
    if (board11 == 2'b01) begin
        game_state <= 2'b10;
    end else if (board11 == 2'b10) begin
        game_state <= 2'b11;
    end
end
if (game_state == 2'b1) begin
    if (1==1
    [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
        && board{{x}}{{y}} != 2'b00
    }]]
    ) begin
        game_state <= 3'b100;
    end
end
