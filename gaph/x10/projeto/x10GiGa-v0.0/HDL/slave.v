// **************************************************************************
// $Header: //Dosequis/D/rcs_proj/dn_fpgacode/dn8000k10sxpci/PCI_interface/Blockram_Access_A/SOURCE/rcs/registers.v 1.1 2006/09/05 18:11:40Z Jack Exp $
// **************************************************************************
// $Log: registers.v $
// Revision 1.1  2006/09/05 18:11:40Z  Jack
// Initial revision
// Revision 1.1  2006/03/24 20:14:26Z  nharder
// Initial revision
// Revision 1.1  2006/03/24 19:42:26Z  nharder
// Initial revision
// Revision 1.1  2005/12/29 00:07:42Z  nharder
// Initial revision
//
// Description:
// Template for Registers accessible over the MainBus Interface

`ifdef INCLUDED_SLAVE_V
`else
`define INCLUDED_SLAVE_V

// --------------------------------------------------------------------------------
// MODULE DECLARATION
// --------------------------------------------------------------------------------
module slave (
    MB_clock,
    MB_reset,
	
	MB_reg_pos1,
	MB_reg_pos2,
	MB_reg_pos3,
	MB_reg_pos4,

    MB_sel_reg,
    MB_write_strobe,
    MB_read_strobe,
    MB_address,
    MB_data_in,
    MB_data_out,
    MB_done

    );

    // DESIGN ID CODE
    parameter ID_CODE = 32'h3500_0121;

    // REGISTER ADDRESSES
    parameter REGADDR_IDCODE    = (6'h00);
    parameter REGADDR_SCRATCH   = (6'h01);

    // --------------------------------------------------------------------------------
    // INPUT OUTPUT DECLARATIONS
    // -------------------------------------------------------------------------------- 
    input         MB_clock;
    input         MB_reset;
	
	output [31:0] MB_reg_pos1;	// Saida do registrador pos1
	input  [31:0] MB_reg_pos2;	// Entrada para o registrador pos2
	input  [31:0] MB_reg_pos3;	// Entrada para o registrador pos3
	input  [31:0] MB_reg_pos4;	// Entrada para o registrador pos4
	
    input         MB_sel_reg;
    input         MB_write_strobe;
    input         MB_read_strobe;
    input  [31:0] MB_address;
    input  [31:0] MB_data_in;
    output [31:0] MB_data_out;
    output        MB_done;


    // --------------------------------------------------------------------------------
    // WIRE AND REG DECLARATIONS
    // --------------------------------------------------------------------------------

    // MODULE OUTPUTS
    reg   [31:0] MB_data_out;    // Module Output
    reg          MB_done;        // Module Output

    // WRITE/READ STROBES
    wire         reg_write_strobe;
    wire         reg_read_strobe;
    reg          reg_read_strobe_d;
    reg          reg_read_strobe_dd;
    reg          reg_read_strobe_ddd;

    // WRITEABLE REGISTERS
	reg   [31:0] pos1;
	reg   [31:0] pos2;
	reg   [31:0] pos3;
	reg   [31:0] pos4;
	reg   [31:0] pos5;
	reg   [31:0] pos6;
	reg   [31:0] pos7;
	reg   [31:0] pos8;
	
	// IO WITH SLAVE HANDLER MODULE
	wire  [31:0] MB_reg_pos1;
	wire  [31:0] MB_reg_pos2;
    wire  [31:0] MB_reg_pos3;
    wire  [31:0] MB_reg_pos4;	
	
    // --------------------------------------------------------------------------------
    // REGISTER IMPLEMENTATION
    // --------------------------------------------------------------------------------
    assign reg_write_strobe = MB_write_strobe & MB_sel_reg;
    assign reg_read_strobe  = MB_read_strobe  & MB_sel_reg;
	
	assign MB_reg_pos1 = pos1;

    always @(posedge MB_clock or posedge MB_reset) begin
		if (MB_reset) begin
			MB_done             <= 1'b0;
			reg_read_strobe_d   <= 1'b0;
			reg_read_strobe_dd  <= 1'b0;
			reg_read_strobe_ddd <= 1'b0;
			MB_data_out         <= 32'b0;
			pos1[31:0]  <= 32'b0;
			pos2[31:0]  <= 32'b0;
			pos3[31:0]  <= 32'b0;
			pos4[31:0]  <= 32'b0;
			pos5[31:0]  <= 32'b0;
			pos6[31:0]  <= 32'b0;
			pos7[31:0]  <= 32'b0;
			pos8[31:0]  <= 32'b0;			 
		end
		else begin
			pos2[31:0] <= MB_reg_pos2[31:0];
			pos3[31:0] <= MB_reg_pos3[31:0];
			pos4[31:0] <= MB_reg_pos4[31:0];
		
			// Latch delayed signals
			reg_read_strobe_d      <= reg_read_strobe;
			reg_read_strobe_dd     <= reg_read_strobe_d;
			reg_read_strobe_ddd    <= reg_read_strobe_dd;

			// Drive default unless register access activates below
			MB_done            <= 1'b0;
			MB_data_out[31:0]  <= 31'b0;

			// Writes
			if (reg_write_strobe) begin
				case (MB_address[5:0])
					1:       pos1[31:0]  <= MB_data_in[31:0];
					// 2:       pos2[31:0]  <= MB_data_in[31:0];
					// 3:       pos3[31:0]  <= MB_data_in[31:0];
					// 4:       pos4[31:0]  <= MB_data_in[31:0];
					5:       pos5[31:0]  <= MB_data_in[31:0];
					6:       pos6[31:0]  <= MB_data_in[31:0];
					7:       pos7[31:0]  <= MB_data_in[31:0];
					8:       pos8[31:0]  <= MB_data_in[31:0];
					default: begin end
             endcase
             MB_done <= 1'b1;
          end

			// Reads
			if (reg_read_strobe_ddd) begin
				case (MB_address[5:0])
					REGADDR_IDCODE:MB_data_out[31:0] <= ID_CODE;
					1:       MB_data_out[31:0] <= pos1[31:0];
					2:       MB_data_out[31:0] <= pos2[31:0];
					3:       MB_data_out[31:0] <= pos3[31:0];
					4:       MB_data_out[31:0] <= pos4[31:0];
					5:       MB_data_out[31:0] <= pos5[31:0];
					6:       MB_data_out[31:0] <= pos6[31:0];
					7:       MB_data_out[31:0] <= pos7[31:0];
					8:       MB_data_out[31:0] <= pos8[31:0];
					default: MB_data_out[31:0] <= 32'hBEEFBEEF;
				endcase
				MB_done <= 1'b1;
			end
		end
	end

endmodule

`endif
