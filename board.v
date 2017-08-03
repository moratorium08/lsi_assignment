// show board
[[w = 10]]
[[h = 300]]
[[base = 40]]
[[for x, y in (0, 0), (100, 0), (200, 0), (300, 0) {
if(col >= {{ base + x }} && col < {{ base + x + w }} && row >= {{ base + y }} && row < {{base + y + h}}) begin
        {red, green, blue} = 3'b000;
end
}]]
[[h = 310]]
[[for x, y in (0, 0), (100, 0), (200, 0), (300, 0) {
if(row >= {{ base + x }} && row < {{ base + x + w }} && col >= {{ base + y }} && col < {{base + y + h}}) begin
        {red, green, blue} = 3'b000;
end
}]]
// maru no hyouji
[[for x, y in eval("[(str(x), str(y)) for x in range(3) for y in range(3)]") {
if (board{{x}}{{y}} == 2'b01) begin
    if (((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
        (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) > 1600 &&
        ((col - `CENTER{{x}}{{y}}x) * (col - `CENTER{{x}}{{y}}x) +
        (row - `CENTER{{x}}{{y}}y) * (row - `CENTER{{x}}{{y}}y)) < 2000) begin
        {red, green, blue} = 3'b000;
    end
end
}]]
// batsu no hyouji
[[for x, y, X, c1, Y, c2 in eval("[(str(x), str(y), 50 + 100 * x, 190 + 100 * (x + y), 50 + 100 * y, x * 100 - y*100) for x in range(3) for y in range(3)]") {
if (board{{y}}{{x}} == 2'b10) begin
    if((col + row ) < ({{c1}} + 10'd10) && (col + row) > {{c1}} && col > ({{X}} + 10'd5)  && col < ({{X}} + 10'd80)) begin
        {red, green, blue} = 3'b000;
    end
    if((row - col + {{c2}}) < 10 && (col - row + {{c2}}) > 10 && col > ({{X}} + 10'd5) && col < ({{X}} + 10'd80)) begin
        {red, green, blue} = 3'b000;
    end
end
}]]
