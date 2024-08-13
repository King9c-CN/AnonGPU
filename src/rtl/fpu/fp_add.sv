module fp_add #(
    parameter DATAWIDTH = 32
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
    reg         start_ena;

    always @(posedge clk) begin
        if(rst) begin
            start_ma <= 'h0;
            start_mb <= 'h0;
            start_ea <= 'h0;
            start_eb <= 'h0;
            start_ena <= 'b0;
        end
        else  begin
            start_ena <= ena;
            start_ma <= {1'b0, 1'b1, a[22:0]};
            start_mb <= {1'b0, 1'b1, b[22:0]};
            start_ea <= a[30:23];
            start_eb <= b[30:23];
        end
    end

    reg [24:0]  zeroCheck_ma, zeroCheck_mb;
    reg [7:0]   zeroCheck_ea, zeroCheck_eb;
    reg         zeroCheck_ena, zeroCheck_nan, zeroCheck_over;

    always @(posedge clk) begin
        if(rst) begin
            zeroCheck_ma <= 'h0;
            zeroCheck_mb <= 'h0;
            zeroCheck_ea <= 'h0;
            zeroCheck_eb <= 'h0;
            zeroCheck_ena <= 'b0;
            zeroCheck_nan <= 'b0;
            zeroCheck_over <= 'b0;
        end
        else begin
            zeroCheck_ma <= start_ma;
            zeroCheck_mb <= start_mb;
            zeroCheck_ea <= start_ea;
            zeroCheck_eb <= start_eb;
            zeroCheck_ena <= start_ena;
            if((start_ea==8'hFF&&start_ma[22:0]!=0)||(start_eb==8'hFF&&start_mb[22:0]!=0)
        end
    end
     


endmodule