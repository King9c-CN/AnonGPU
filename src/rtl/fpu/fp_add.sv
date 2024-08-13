module fp_add #(
    parameter DATAWIDTH = 32,
    parameter NORMAL = 2'b00,
    parameter NaN = 2'b01,
    parameter INF = 2'b10,
    parameter ZERO = 2'b11
) 
(
    input [DATAWIDTH-1:0]       a,
    input [DATAWIDTH-1:0]       b,
    input                       ena,
    input                       clk,
    input                       rst,

    output reg [DATAWIDTH-1:0]  s,
    output reg                  s_ena,
    output reg                  nan,
    output reg                  over,
    output done
);
    reg [24:0]  start_ma, start_mb;
    reg [7:0]   start_ea, start_eb;
    reg [1:0]   start_st; // 00: normal 01: NaN 10:inf 11:zero
    reg         start_ena, start_sa, start_sb;

//start stage
    always @(posedge clk) begin
        if(rst) begin
            start_ma <= 'd0;
            start_mb <= 'd0;
            start_ea <= 'd0;
            start_eb <= 'd0;
            start_st <= NORMAL;
            start_ena <= 'd0;
            start_sa <= 'd0;
            start_sb <= 'd0;
        end
        else if(ena) begin
            start_ena = 'b1;
            if(a[30:23] == 8'hFF) begin
                if(a[22:0] != 0) begin
                    start_st <= NaN;
                end
                else begin
                    start_st <= INF;
                end
            end
            else if (b[30:23] == 8'hFF)begin
                if(b[22:0] != 0) begin
                    start_st <= NaN;
                end
                else begin
                    start_st <= INF;
                end
            end
            else begin
                start_st <= NORMAL;
                start_ea <= a[30:23];
                start_eb <= b[30:23];
                start_sa <= a[31];
                start_sb <= b[31];
                if(a[30:23] == 8'h0) begin
                    start_ma <= {1'b0, 1'b0, a[22:0]};
                end
                else begin
                    start_ma <= {1'b0, 1'b1, a[22:0]};
                end
                if (b[30:23] == 8'h0) begin
                    start_mb <= {1'b0, 1'b0, b[22:0]};
                end
                else begin
                    start_mb  <=  {1'b0, 1'b1, b[22:0]};
                end
            end
        end
    end
     



endmodule