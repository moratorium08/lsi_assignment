if (late3 == 1'b1) begin
    late3 <= 1'b0;
    if (cnt == 9'd0) begin
        if (put[9'd0] == 9'd9) begin
            if (1 !=1) begin
            end
            [[for x, y, i in eval("[(str(x), str(y), str(3*x + y)) for x in range(3) for y in range(3)]") {
                else if (board{{x}}{{y}} == 3'b0) begin
                    next_put <= 9'd{{i}};
                end
            }]]

        end else begin
            next_put <= put[9'd0];
        end
    end else begin
        see <= put[cnt - 9'd1];
        cnt <= cnt - 9'd1;
        my_turn <= my_turn ^ 9'b11;
        put[cnt] <= 9'd9;
    end
end else begin
    late2 <= late2 ^ 1'b1;
    if (late2 == 0) begin
        if (1!=1) begin
        end
        [[for x in eval("[str(x) for x in range(3)]") {
            else if (board{{x}}0 == 3'b01 && board{{x}}1 == 3'b01 && board{{x}}2 == 3'b01) begin
                winner <= 9'd1;
            end else if (board{{x}}0 == 3'b10 && board{{x}}1 == 3'b10 && board{{x}}2 == 3'b10) begin
                winner <= 9'd2;
            end else if (board0{{x}} == 3'b01 && board1{{x}} == 3'b01 && board2{{x}} == 3'b01) begin
                winner <= 9'd1;
            end else if (board0{{x}} == 3'b10 && board1{{x}} == 3'b10 && board2{{x}} == 3'b10) begin
                winner <= 9'd2;
            end
        }]]
        else if (board00 == board11  && board11 == board22) begin
            if (board00 == 3'b01) begin
                winner <= 9'd1;
            end else if (board00 == 3'b10) begin
                winner <= 9'b10;
            end
        end else if (board20 == board11  && board11 == board02) begin
            if (board11 == 3'b01) begin
                winner <= 9'd1;
            end else if (board11 == 3'b10) begin
                winner <= 9'd2;
            end
        end else if (1==1
            [[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
                && board{{x}}{{y}} != 3'b00
            }]]
            ) begin
                winner <= 9'd3;
        end else begin
            winner <= 9'd0;
        end
    end else begin
        winner <= 9'd0;
        if (current_winner == 9'd8 && winner != 9'd0) begin
            current_winner <= winner;
            cnt <= cnt - 9'd1;
            put[cnt] <= 9'd9;
            // draw_put[cnt] <= 9'd9;
            my_turn <= my_turn ^ 9'b11;
        end else if (current_winner == my_turn && cnt == 0) begin
            next_put <= put[9'd0];
        end else if (see > 9'd8) begin
            if (draw_put[cnt] != 9'd9) begin
                current_winner <= 9'd3;
            end else begin
                current_winner <= my_turn ^ 9'b11;
            end
            put[cnt] <= draw_put[cnt];
            draw_put[cnt] <= 9'd9;
            late3 <= 1'b1;
        end else begin
            if (current_winner == 9'd8) begin
                if (1!=1) begin
                end
                [[for x, y, i in eval("[(str(x), str(y), str(3 * x + y)) for x in range(3) for y in range(3)]") {
                    else if (see == 9'd{{i}} && board{{x}}{{y}} == 3'd0) begin
                        if (my_turn == 9'd2) begin
                            board{{x}}{{y}} <= 3'd2;
                        end else begin
                            board{{x}}{{y}} <= 3'd1;
                        end
                        put[cnt] <= 9'd{{i}};
                        my_turn <= my_turn ^ 3'b11;
                        cnt <= cnt + 4'd1;
                        see <= 9'd0;
                    end
                }]]
                else begin
                    see <= see + 9'd1;
                end
            end else begin
                [[for x, y, i in eval("[(str(x), str(y), str(3 * x + y)) for x in range(3) for y in range(3)]") {
                    if (9'd{{i}} == put[cnt]) begin
                        board{{x}}{{y}} <= 3'b0;
                    end
                }]]
                if (current_winner == my_turn) begin
                    put[cnt] <= 9'd9;
                    draw_put[cnt] <= 9'd9;
                    see <= put[cnt - 4'd1];
                    cnt <= cnt - 9'd1;
                    my_turn <= my_turn ^ 9'b11;
                end else if(current_winner == 9'd3) begin
                    current_winner <= 9'd8;
                    draw_put[cnt] <= put[cnt];
                    see <= put[cnt] + 9'd1;
                    put[cnt] <= 9'd9;
                end else begin
                    see <= see + 9'd1;
                    current_winner <= 9'd8;
                end
            end
        end
    end
end
