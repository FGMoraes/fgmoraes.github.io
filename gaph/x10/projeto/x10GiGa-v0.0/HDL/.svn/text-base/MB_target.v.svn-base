// **************************************************************************
// $Header: //Dosequis/D/rcs_proj/dn_fpgacode/common/MainBus/rcs/MB_target.v 1.3 2006/03/28 22:27:40Z nharder Exp $
// **************************************************************************
// $Log: MB_target.v $
// Revision 1.3  2006/03/28 22:27:40Z  nharder
// Added note about "done" line.
// Revision 1.2  2006/03/28 19:34:10Z  nharder
// Revision 1.1  2006/03/24 19:42:27Z  nharder
// Initial revision
// Revision 1.4  2006/02/14 17:31:20Z  nharder
// Put entire address out on MB_address, including FPGA addr[31:28] and mb_sel[27:26] addr- targets can use whatever portion they wish.
// Revision 1.3  2006/01/18 19:35:39Z  nharder
// Added some useful comments.
// Revision 1.2  2006/01/17 22:18:05Z  nharder
// Inverted done logic.  Split mainbus into inout, in, and out busses.
// Revision 1.1  2005/12/29 00:07:43Z  nharder
// Initial revision
//
// MAINBUS INTERFACE MODULE:
// This module provides input and output flipflops, an address latch,
// and basic address decoding for the Main Bus Interface.
// **************************************************************************

`ifdef INCLUDED_MAINBUS_V
`else
`define INCLUDED_MAINBUS_V

// ----------------------------------------------------------------------------------
// MODULE DECLARATION
// ----------------------------------------------------------------------------------
module MB_target (
    MB_inout,
    MB_in,
    MB_out,

    MB_clock,
    MB_reset,

    MB_address,
    MB_sel_0,
    MB_sel_1,
    MB_sel_2,
    MB_sel_3,
    MB_sel_4,
    MB_sel_5,
    MB_sel_6,
    MB_sel_7,
    MB_sel_8,
    MB_sel_9,
    MB_sel_10,
    MB_sel_11,
    MB_sel_12,
    MB_sel_13,
    MB_sel_14,
    MB_sel_15,    

    MB_write_strobe,
    MB_read_strobe,
    MB_data_in,

    MB_data_out,
    MB_done

    );

    parameter FPGANUM = 4'b0010; // Defparam this to appropriate FPGA address

    // ----------------------------------------------------------------------------------
    // INPUT OUTPUT DECLARATIONS
    // ----------------------------------------------------------------------------------
    inout   [31:0] MB_inout;
    input  [34:32] MB_in;

    // NOTE: Some boards use MB[36] and some use MB[35] for the "done" signal.
    //       Double check that the right line is connected here.
    output [35:35] MB_out;

    input         MB_clock;
    input         MB_reset;

    output        MB_sel_0;
    output        MB_sel_1;
    output        MB_sel_2;
    output        MB_sel_3;
    output        MB_sel_4;
    output        MB_sel_5;
    output        MB_sel_6;
    output        MB_sel_7;
    output        MB_sel_8;
    output        MB_sel_9;
    output        MB_sel_10;
    output        MB_sel_11;
    output        MB_sel_12;
    output        MB_sel_13;
    output        MB_sel_14;
    output        MB_sel_15;    

    output        MB_write_strobe;
    output        MB_read_strobe;
    output [31:0] MB_address;
    output [31:0] MB_data_in;

    input  [31:0] MB_data_out;
    input         MB_done;

    // ----------------------------------------------------------------------------------
    // WIRE AND REG DECLARATIONS
    // ----------------------------------------------------------------------------------
    // Input Flipflops
    reg  [31:0] MB_data_d;
    reg [34:32] MB_control_d;

    // Output Flipflops
    reg  [31:0] MB_data_out_d;
    reg         MB_done_n_d;

    // Registered Output Enables
    reg         data_output_enable;
    reg         control_output_enable;

    // Address Latch
    reg  [31:0] mbbus_addr_in;
    wire        mbbus_addr_strobe;

    // Address Decode
    wire        fpga_sel;
    wire        sel_0;
    wire        sel_1;
    wire        sel_2;
    wire        sel_3;
    wire        sel_4;
    wire        sel_5;
    wire        sel_6;
    wire        sel_7;
    wire        sel_8;
    wire        sel_9;
    wire        sel_10;
    wire        sel_11;
    wire        sel_12;
    wire        sel_13;
    wire        sel_14;
    wire        sel_15;   
    wire        selected;


    // ----------------------------------------------------------------------------------
    // INPUT FLIPFLOPS
    // ----------------------------------------------------------------------------------
    always @(posedge MB_clock or posedge MB_reset) begin
        if (MB_reset) begin
            MB_data_d    <= 'b0;
            MB_control_d <= 'b0;
        end
        else begin
            MB_data_d[31:0]     <= MB_inout[31:0];
            MB_control_d[34:32] <= MB_in[34:32];
        end
    end
    assign MB_data_in         = MB_data_d[31:0];
    assign mbbus_addr_strobe  = MB_control_d[32];
    assign MB_write_strobe    = MB_control_d[33];
    assign MB_read_strobe     = MB_control_d[34];


    // ----------------------------------------------------------------------------------
    // OUTPUT FLIPFLOPS
    // ----------------------------------------------------------------------------------
    always @(posedge MB_clock or posedge MB_reset) begin
        if (MB_reset) begin
            data_output_enable     <= 1'b0;
            control_output_enable  <= 1'b0;
            MB_data_out_d          <= 1'b0;
            MB_done_n_d            <= 1'b0;
        end
        else begin
            control_output_enable <= (selected);
            data_output_enable    <= (selected & MB_done); // Note: drives data lines on write-dones as well as read-dones

            MB_data_out_d         <= MB_data_out;
            MB_done_n_d           <= MB_done;    // DONE IS ACTIVE LOW ON THE DN7000K10PCI!!!
        end
    end
    assign MB_inout[31:0]  = (data_output_enable)    ? MB_data_out_d   : {32{1'bz}};
    assign MB_out[35]      = (control_output_enable) ? MB_done_n_d     : 1'bz;


    // ----------------------------------------------------------------------------------
    // ADDRESS LATCH
    // ----------------------------------------------------------------------------------
    always @(posedge MB_clock or posedge MB_reset) begin
        if (MB_reset) begin
            mbbus_addr_in[31:0] <= 32'b0;
        end
        else begin
            if (mbbus_addr_strobe) begin
                mbbus_addr_in[31:0] <= MB_data_d[31:0];
            end
        end
    end

    // ----------------------------------------------------------------------------------
    // ADDRESS DECODE
    // ----------------------------------------------------------------------------------
    // MB[31:28] : FPGA number, A=0, B=1, C=2, etc.
    // MB[27:26] : Range Select: registers, internal memories, etc.
    assign fpga_sel  = mbbus_addr_in[31:28] == FPGANUM;
    
    assign sel_0     = mbbus_addr_in[27:24] == 4'b0000; // BASE ADDRESS: 0x0000_0000
    assign sel_1     = mbbus_addr_in[27:24] == 4'b0001; // BASE ADDRESS: 0x0100_0000
    assign sel_2     = mbbus_addr_in[27:24] == 4'b0010; // BASE ADDRESS: 0x0200_0000
    assign sel_3     = mbbus_addr_in[27:24] == 4'b0011; // BASE ADDRESS: 0x0300_0000
    assign sel_4     = mbbus_addr_in[27:24] == 4'b0100; // BASE ADDRESS: 0x0400_0000
    assign sel_5     = mbbus_addr_in[27:24] == 4'b0101; // BASE ADDRESS: 0x0500_0000
    assign sel_6     = mbbus_addr_in[27:24] == 4'b0110; // BASE ADDRESS: 0x0600_0000
    assign sel_7     = mbbus_addr_in[27:24] == 4'b0111; // BASE ADDRESS: 0x0700_0000
    assign sel_8     = mbbus_addr_in[27:24] == 4'b1000; // BASE ADDRESS: 0x0800_0000
    assign sel_9     = mbbus_addr_in[27:24] == 4'b1001; // BASE ADDRESS: 0x0900_0000
    assign sel_10    = mbbus_addr_in[27:24] == 4'b1010; // BASE ADDRESS: 0x0A00_0000
    assign sel_11    = mbbus_addr_in[27:24] == 4'b1011; // BASE ADDRESS: 0x0B00_0000
    assign sel_12    = mbbus_addr_in[27:24] == 4'b1100; // BASE ADDRESS: 0x0C00_0000
    assign sel_13    = mbbus_addr_in[27:24] == 4'b1101; // BASE ADDRESS: 0x0D00_0000
    assign sel_14    = mbbus_addr_in[27:24] == 4'b1110; // BASE ADDRESS: 0x0E00_0000
    assign sel_15    = mbbus_addr_in[27:24] == 4'b1111; // BASE ADDRESS: 0x0F00_0000    
    
    assign selected  = (fpga_sel & (sel_0  | sel_1  | sel_2  | sel_3  | 
				    sel_4  | sel_5  | sel_6  | sel_7  | 
				    sel_8  | sel_9  | sel_10 | sel_11 | 
				    sel_12 | sel_13 | sel_14 | sel_15));

    assign MB_sel_0   = fpga_sel & sel_0;
    assign MB_sel_1   = fpga_sel & sel_1;
    assign MB_sel_2   = fpga_sel & sel_2;
    assign MB_sel_3   = fpga_sel & sel_3;
    assign MB_sel_4   = fpga_sel & sel_4;
    assign MB_sel_5   = fpga_sel & sel_5;
    assign MB_sel_6   = fpga_sel & sel_6;
    assign MB_sel_7   = fpga_sel & sel_7;
    assign MB_sel_8   = fpga_sel & sel_8;
    assign MB_sel_9   = fpga_sel & sel_9;
    assign MB_sel_10  = fpga_sel & sel_10;
    assign MB_sel_11  = fpga_sel & sel_11;
    assign MB_sel_12  = fpga_sel & sel_12;
    assign MB_sel_13  = fpga_sel & sel_13;
    assign MB_sel_14  = fpga_sel & sel_14;
    assign MB_sel_15  = fpga_sel & sel_15;    

    // ----------------------------------------------------------------------------------
    // DRIVE FPGA INTERFACE OUTPUTS
    // ----------------------------------------------------------------------------------
    assign MB_address[31:0]   = mbbus_addr_in[31:0];

endmodule

`endif

