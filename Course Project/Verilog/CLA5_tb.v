`timescale 1ns / 1ps

module cla_5bit_nand_only_tb;
    reg [4:0] a_in, b_in;
    reg cin, clk;
    wire [4:0] sum;
    wire cout;

    // instantiate DUT
    cla_5bit_nand_only uut (
        .cout(cout),
        .sum(sum),
        .a_in(a_in),
        .b_in(b_in),
        .cin(cin),
        .clk(clk)
    );

    // 10 timeunit clock period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // print helper showing before/after sampling
    task print_before(input [4:0] ai, input [4:0] bi, input c);
        begin
            $display("\nT=%0t APPLY inputs a_in=%b b_in=%b cin=%b (will be sampled on next posedge)", $time, ai, bi, c);
            $display("  registered a=%b b=%b  sum(reg)=%b cout=%b", uut.a, uut.b, sum, cout);
        end
    endtask

    task print_after_sample();
        begin
            $display("\nT=%0t AFTER posedge (inputs sampled): a=%b b=%b", $time, uut.a, uut.b);
            $display("  combinational sum_comb=%b cout(comb)=%b  (sum reg still previous until next posedge)", uut.sum_comb, uut.cout);
        end
    endtask

    task print_after_output();
        begin
            $display("\nT=%0t AFTER next posedge (outputs registered): sum=%b cout=%b", $time, sum, cout);
        end
    endtask

    initial begin
        $dumpfile("cla_tb.vcd");
        $dumpvars(0, cla_5bit_nand_only_tb);

        // vector 0
        a_in = 5'b00000; b_in = 5'b00000; cin = 0;
        #2; print_before(a_in, b_in, cin);
        @(posedge clk); #1; print_after_sample();
        @(posedge clk); #1; print_after_output();

        // vector 1
        a_in = 5'b00001; b_in = 5'b00001; cin = 0;
        #2; print_before(a_in, b_in, cin);
        @(posedge clk); #1; print_after_sample();
        @(posedge clk); #1; print_after_output();

        // vector 2
        a_in = 5'b01111; b_in = 5'b00001; cin = 0;
        #2; print_before(a_in, b_in, cin);
        @(posedge clk); #1; print_after_sample();
        @(posedge clk); #1; print_after_output();

        // vector 3
        a_in = 5'b10101; b_in = 5'b01010; cin = 0;
        #2; print_before(a_in, b_in, cin);
        @(posedge clk); #1; print_after_sample();
        @(posedge clk); #1; print_after_output();

        // vector 4
        a_in = 5'b11111; b_in = 5'b11111; cin = 0;
        #2; print_before(a_in, b_in, cin);
        @(posedge clk); #1; print_after_sample();
        @(posedge clk); #1; print_after_output();

        #20;
        $finish;
    end

    initial begin
        $monitor("T=%0t a_in=%b b_in=%b cin=%b | sum=%b cout=%b", $time, a_in, b_in, cin, sum, cout);
    end
endmodule