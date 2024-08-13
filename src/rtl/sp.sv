module sp (
    input               clk,
    input               Resetn,
    input               clr,
    input               ena,
    input               start,
    input [31:0]        rs_a,
    input [31:0]        rs_b,
    input [31:0]        rs_c,
    input [8:0]         addr_d,
    input [2:0]         Sp,
    input [2:0]         Dp,           
    input [2:0]         modifier,
    input               Si,
    input [5:0]         opcode,
    input [7:0]         thread_cnt,

    output reg [31:0]   out,
    output reg [8:0]    des_addr,
    output reg [2:0]    des_pre,
    output reg [4:0]    sp_cnt,
    output reg          ack,
    output reg          set_pc_req,
    output reg          outen
);





endmodule