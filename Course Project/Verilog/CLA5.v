module cla_5bit_nand_only (
    output reg cout,
    output reg [4:0] sum,
    input [4:0] a_in, b_in,
    input cin,
    input clk
);

    reg [4:0] a, b;
    reg [4:0] sum_comb;

    // Sample inputs on clock
    always @(posedge clk) begin
        a <= a_in;
        b <= b_in;
    end

    // NAND Logic Gates as Tasks (Using assign blocks instead of invalid function bodies)
    function automatic nand2(input x, input y);
        nand2 = ~(x & y);
    endfunction

    function automatic inv(input x);
        inv = ~(x & x);
    endfunction

    function automatic and2(input x, input y);
        and2 = ~(~(x & y));
    endfunction

    function automatic or2(input x, input y);
        or2 = ~((~x) & (~y));
    endfunction

    function automatic xor2(input x, input y);
        reg n1, n2, n3;
        begin
            n1 = ~(x & y);
            n2 = ~(x & n1);
            n3 = ~(y & n1);
            xor2 = ~(n2 & n3);
        end
    endfunction

    // Combinational logic
    wire [4:0] g, p;
    wire c0, c1, c2, c3, c4;

    assign g[0] = and2(a[0], b[0]);
    assign g[1] = and2(a[1], b[1]);
    assign g[2] = and2(a[2], b[2]);
    assign g[3] = and2(a[3], b[3]);
    assign g[4] = and2(a[4], b[4]);

    assign p[0] = xor2(a[0], b[0]);
    assign p[1] = xor2(a[1], b[1]);
    assign p[2] = xor2(a[2], b[2]);
    assign p[3] = xor2(a[3], b[3]);
    assign p[4] = xor2(a[4], b[4]);

    assign c0 = or2(g[0], and2(p[0], cin));
    assign c1 = or2(or2(g[1], and2(p[1], g[0])), and2(p[1] & p[0], cin));
    assign c2 = or2(or2(g[2], and2(p[2], g[1])), or2(and2(p[2] & p[1], g[0]), and2(p[2] & p[1] & p[0], cin)));
    assign c3 = or2(or2(g[3], and2(p[3], g[2])),
              or2(and2(p[3] & p[2], g[1]),
              or2(and2(p[3] & p[2] & p[1], g[0]),
                  and2(p[3] & p[2] & p[1] & p[0], cin))));
    assign c4 = or2(or2(g[4], and2(p[4], g[3])),
              or2(and2(p[4] & p[3], g[2]),
              or2(and2(p[4] & p[3] & p[2], g[1]),
              or2(and2(p[4] & p[3] & p[2] & p[1], g[0]),
                  and2(p[4] & p[3] & p[2] & p[1] & p[0], cin)))));

    always @(*) begin
        sum_comb[0] = xor2(p[0], cin);
        sum_comb[1] = xor2(p[1], c0);
        sum_comb[2] = xor2(p[2], c1);
        sum_comb[3] = xor2(p[3], c2);
        sum_comb[4] = xor2(p[4], c3);
    end

    always @(posedge clk) begin
        sum <= sum_comb;
        cout <= c4;
    end

endmodule
