// **************************************************************************
// $Header: //Dosequis/D/rcs_proj/dn_fpgacode/dn8000k10sxpci/PCI_interface/Blockram_Access_A/SOURCE/rcs/fpga.v 1.4 2007/01/10 00:35:33Z nharder Exp $
// **************************************************************************
//
// DESCRIPTION:
// This design shows the use of the ql5064_interface module to connect FPGA_A
// to the PCI bus.  The supported BAR's are connected to blockram memory.
// ACLK should be set in the range of 32-150 Mhz (DCM in MS, Low Freq. mode)
//
// $Log: fpga.v $
// Revision 1.4  2007/01/10 00:35:33Z  nharder
// Common files are now in "common/QL5064_Interface".
// Revision 1.3  2007/01/05 18:37:04Z  Jack
// Revision 1.2  2006/09/18 21:04:30Z  Jack
// use MB[35] as done signal
// Revision 1.1  2006/09/05 18:11:38Z  Jack
// Initial revision
// Revision 1.10  2006/05/01 17:44:38Z  nharder
// Added comments about include directives.
// Revision 1.9  2006/03/28 22:28:33Z  nharder
// Fixed MainBus access.
// Revision 1.8  2006/03/24 21:23:06Z  nharder
// Added MB support.
// Revision 1.7  2006/03/03 19:41:50Z  nharder
// Added comments on ACLK speed.
// Revision 1.6  2005/10/17 22:25:53Z  nharder
// Revision 1.5  2005/07/06 02:21:39Z  nharder
// Added FPGA_A mainbus reset.  Switched to ql5064_interface module.
// Revision 1.4  2005/06/15 20:55:45Z  nharder
// Revision 1.3  2005/06/10 23:23:56Z  nharder
// Respond to all BARS even if not implemented.
// Revision 1.2  2005/06/10 17:41:10Z  nharder
// Changed polartiy of reset. Changed LED behavior.
// Revision 1.1  2005/06/06 22:43:48Z  nharder
// Initial revision
// Revision 1.14  2005/05/26 00:49:10Z  nharder
// Removed unused state variable definitions.
// Revision 1.13  2005/05/25 23:25:12Z  nharder
// Changed port names to match schematic.
// Revision 1.12  2005/05/19 17:54:30Z  nharder
// Revision 1.11  2005/05/18 22:14:51Z  nharder
// Added DCM's for clocks.
// Revision 1.10  2005/05/17 18:41:24Z  nharder
// Added define for memory address widths for easier modification.
// Revision 1.9  2005/05/16 18:32:32Z  nharder
// Added support for target write latency.
// Revision 1.8  2005/05/12 19:36:36Z  nharder
// Widened address ports to 64 bits.
// Increased size of internal memories for larger tests.
// Revision 1.7  2005/05/12 16:16:54Z  nharder
// Added defparams for programmable latencies.
// Revision 1.6  2005/05/12 16:10:08Z  nharder
// Added handling of read and write latency for DMA engines.
// Revision 1.5  2005/05/10 23:43:08Z  nharder
// Added read_enable and read_data_valid signals to T0 and T1.
// Revision 1.4  2005/05/06 19:46:00Z  nharder
// Added separate DMA FIFOs to input side.
// Revision 1.3  2005/04/28 20:49:25Z  nharder
// Made RDY signals active low.
// Revision 1.2  2005/04/26 16:39:32Z  nharder
// Pulled PCI stuff into separate file.  Cleaned everything up a bit.
// Revision 1.1  2005/04/25 17:17:12Z  nharder
// Initial revision
//
// **************************************************************************


`timescale  1 ns / 1 ps


// ---------------------------------------------------------------
// INCLUDE EXTERNAL FILES
// ---------------------------------------------------------------

// This file is the synplicity library file- if synplicity is not
// being used, this file may not be required.
`ifdef synthesis
 `include "virtex4.v"
`endif

// ---------------------------------------------------------------
// MODULE DECLARATION
// ---------------------------------------------------------------
module fpga (
    // CLOCK AND RESET
    ACLKA, // 32-150 Mhz
    ACLKAN,
    SYSCLK_A, // Fixed at 48 Mhz
    FPGA_A_RSTn,

    MB
    );
   
    // ---------------------------------------------------------------
    // INPUT AND OUTPUT DECLARATIONS
    // ---------------------------------------------------------------

    // CLOCK AND RESET
    input         ACLKA; // 32-150 Mhz
    input         ACLKAN;
    input         SYSCLK_A; // Fixed at 48 Mhz
    input         FPGA_A_RSTn;

    // MAINBUS
    inout  [36:0] MB;

    // ---------------------------------------------------------------
    // WIRE AND REG DECLARATIONS
    // ---------------------------------------------------------------

    // CLOCKS
    wire        aclk_ibufg;
    wire        sysclka_ibufg;

    wire        user_clock;
    wire        user_clock_prebufg;
    wire        user_dcm_lock;

    wire        mb_clock;
    wire        mb_clock_prebufg;
    wire        mb_dcm_lock;

    // RESET
    wire        user_reset;

    // MAINBUS
    wire [31:0] mb_address;

    wire        mb_reg_sel_0;
    wire        mb_reg_sel_1;
    wire        mb_reg_sel_2;
    wire        mb_reg_sel_3;
    wire        mb_reg_sel_4;
    wire        mb_reg_sel_5;
    wire        mb_reg_sel_6;
    wire        mb_reg_sel_7;
    wire        mb_reg_sel_8;    
    wire        mb_reg_sel_9;
    wire        mb_reg_sel_10;
    wire        mb_reg_sel_11;
    wire        mb_reg_sel_12;    
    wire        mb_reg_sel_13;
    wire        mb_reg_sel_14;    
    wire        mb_reg_sel_15;    
    
    wire        mb_wr;
    wire        mb_rd;
    
    wire        mb_done;
    wire        mb_done_0;
    wire        mb_done_1;
    wire        mb_done_2;
    wire        mb_done_3;
    wire        mb_done_4;
    wire        mb_done_5;
    wire        mb_done_6;
    wire        mb_done_7;
    wire        mb_done_8;
    wire        mb_done_9;
    wire        mb_done_10;
    wire        mb_done_11;
    wire        mb_done_12;
    wire        mb_done_13;
    wire        mb_done_14;
    wire        mb_done_15;

    wire [31:0] mb_data_out;
    wire [31:0] mb_data_out_0;
    wire [31:0] mb_data_out_1;
    wire [31:0] mb_data_out_2;
    wire [31:0] mb_data_out_3;
    wire [31:0] mb_data_out_4;
    wire [31:0] mb_data_out_5;
    wire [31:0] mb_data_out_6;
    wire [31:0] mb_data_out_7;
    wire [31:0] mb_data_out_8;
    wire [31:0] mb_data_out_9;
    wire [31:0] mb_data_out_10;
    wire [31:0] mb_data_out_11;	 
    wire [31:0] mb_data_out_12;
    wire [31:0] mb_data_out_13;    
    wire [31:0] mb_data_out_14;
    wire [31:0] mb_data_out_15;
    
    wire [31:0] mb_data_in;
	
	// Gerador de Frames
	wire [63:0] geraframesout;
	
	//Top
	wire [63:0] topx10gigaout;
	
	// Frames Handler
	wire we;
	//wire donew;
	wire [31:0] douthi;
	wire [31:0] doutlo;
	
	// Slave Handler
	wire re;
	wire doner;
	wire [7:0] mem;
	wire [9:0] addr;
	
	// Slave
	wire [31:0] MB_reg_pos1;
	wire [31:0] MB_reg_pos2;
	wire [31:0] MB_reg_pos3;
	wire [31:0] MB_reg_pos4;
	
	wire [63:0] assinatura;
	wire clk0_out;
	wire clk180_out;
	wire	clk2x_out;
	wire	rst_out;
	wire	valid_out;	
	
	
	
    // ---------------------------------------------------------------
    // IBUFG, DCM, AND BUFG FOR ACLK: 32-150 Mhz
    // ---------------------------------------------------------------
    IBUFGDS_LVDSEXT_25 ACLK_IBUFG0 (.O(aclk_ibufg), .I(ACLKA), .IB(ACLKAN));

    DCM USER_DCM (
        .CLKIN    (aclk_ibufg),
        .CLKFB    (user_clock),
        .LOCKED   (user_dcm_lock),
        .CLK0     (user_clock_prebufg),
        .RST      (board_reset),
        // Unused ports
        .CLK180   (), .CLK270   (), .CLK2X    (), .CLK2X180 (), .CLK90    (),
        .CLKDV    (), .CLKFX    (), .CLKFX180 (), .PSDONE   (), .STATUS   (),
        .DSSEN(1'b0), .PSCLK(1'b0), .PSEN (1'b0), .PSINCDEC(1'b0)
    ); 

    BUFG USER_BUFG(.O(user_clock), .I(user_clock_prebufg));

    // ---------------------------------------------------------------
    // BUFG FOR MAINBUS CLOCK (48 Mhz)
    // ---------------------------------------------------------------
    // ---------------------------------------------------------------
    // IBUFG, DCM, AND BUFG FOR SYSCLK_A
    // ---------------------------------------------------------------
    IBUFG SYSCLKA_IBUFG (.O(sysclka_ibufg), .I(SYSCLK_A));

    DCM MB_DCM (
        .CLKIN    (sysclka_ibufg),
        .CLKFB    (mb_clock),
        .LOCKED   (mb_dcm_lock),
        .CLK0     (mb_clock_prebufg),
        .RST      (board_reset),
        // Unused ports
        .CLK180   (), .CLK270   (), .CLK2X    (), .CLK2X180 (), .CLK90    (),
        .CLKDV    (), .CLKFX    (), .CLKFX180 (), .PSDONE   (), .STATUS   (),
        .DSSEN(1'b0), .PSCLK(1'b0), .PSEN (1'b0), .PSINCDEC(1'b0)
    ); 

    BUFG MB_BUFG(.O(mb_clock), .I(mb_clock_prebufg));


    // ---------------------------------------------------------------
    // RESET GENERATION (External reset gated with DCM lock signals)
    // ---------------------------------------------------------------
    	assign board_reset = (~FPGA_A_RSTn);
    	assign user_reset  = (board_reset) | (~user_dcm_lock) | (~mb_dcm_lock);

	//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	//Gerdaor de Frames
	// geraframes i_geraframes(
		// .clk(user_clock),		// Clock
		// .rst(user_reset),		// Reset			// Orientações:
	 	// .saida(geraframesout)	// Output			- Vai pro Top
	// );

	//Aqui insere o Módulo Top do X10GiGA
	top_frame_fec i_top_frame_fec(
		.clk(user_clock),		// Clock
		.rst(user_reset),		// Reset			// Orientações:
		//.done(donew),			// Write Done		- Vem do Frames Handler
		//.entrada(geraframesout),// Input			- Vem do Gerador de Frames
		.saida(topx10gigaout),	// Output			- Vai pro Frames Handler
		.we(we)					// Write Enable		- Vai pro Frames Handler
	);
	
	
	// Módulo Top do V0
//	top_frame_fec top_frame_fec (
//		.clock_in(user_clock),
//		.reset_placa(user_reset),
//		.entrada(geraframesout),
//		.saida(topx10gigaout),
//		.assinatura(assinatura),
//		.clk0_out(clk0_out),
//		.clk180_out(clk180_out),
//		.clk2x_out(clk2x_out),
//		.rst_out(rst_out),
//		.valid_out(valid_out)
//	);	
		
	// Frames Handler
	frameshandler i_frameshandler(
		.clk(user_clock),	    // Clock
		.rst(user_reset),       // Reset			// Orientações:
		.we(we),			    // Write Enable		- Vem do Top
		.din(topx10gigaout),	// Input			- Vem do Top
		//.donew(donew),		  	// Write Done		- Vai pro Top
		.re(re),			    // Read Enable		- Vem do Slave Handler
		.mem(mem),			    // Memory Select		- Vem do Slave Handler
		.addr(addr),		    // Memory Address	- Vem do Slave Handler
		.doner(doner),		  	// Read Done		- Vai pro Slave Handler
		.douthi(douthi),		// Output (high)		- Vai pro Slave Handler
		.doutlo(doutlo) 		// Output (low)		- Vai pro Slave Handler
	);                    
	
	// Slave Handler
	slavehandler i_slavehandler(
		.clk(user_clock),		// Clock
		.rst(user_reset),		// Reset
		.doner(doner),			// Entrada que indica final dos frames disponíveis para leitura
		.dinMB(MB_reg_pos1),	// Entrada dos dados vindos do slave com a informação contida no reg pos1
		.dinhi(douthi),			// Entrada dos dados vindos do frames handler (high)
		.dinlo(doutlo),			// Entrada dos dados vindos do frames handler (low)
		.re(re),				// Saída do read enable para leitura dos dados do frames handler
		.mem(mem),				// Saída de memory select para leitura dos dados do frames handler
		.addre(addr),			// Saída de memory address para leitura dos dados do frames handler
		.doutMB(MB_reg_pos2),	// Saída de dados para o reg pos2 do slave com a mesma informação vinda do reg pos1 indicando transação efetivada
		.douthi(MB_reg_pos3),	// Saída dos dados vindos do frames handler (high) para o reg pos3 do slave
		.doutlo(MB_reg_pos4)	// Saída dos dados vindos do frames handler (low) para o reg pos4 do slave
	);

	// Slave
	// Desabilitar os outros slaves???
    slave i_slave_0 (
        .MB_clock(mb_clock),
        .MB_reset(user_reset),		// Orientações:
		.MB_reg_pos1(MB_reg_pos1),	// Saida do registrador pos1			- Vai pro Slave Handler
		.MB_reg_pos2(MB_reg_pos2),	// Entrada para o registrador pos2		- Vem do Slave Handler
		.MB_reg_pos3(MB_reg_pos3),	// Entrada para o registrador pos3		- Vem do Slave Handler
		.MB_reg_pos4(MB_reg_pos4),	// Entrada para o registrador pos4		- Vem do Slave Handler
        .MB_sel_reg(mb_reg_sel_0),
        .MB_write_strobe(mb_wr),
        .MB_read_strobe(mb_rd),
        .MB_address(mb_address),
        .MB_data_in(mb_data_in),
        .MB_data_out(mb_data_out_0),
        .MB_done(mb_done_0)
    );
	//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	

    // ---------------------------------------------------------------
    // MainBus Support
    // ---------------------------------------------------------------
    MB_target i_MB_target (
        .MB_inout(MB[31:0]),
        .MB_in(MB[34:32]),
        .MB_out(MB[36]),

        .MB_clock(mb_clock),
        .MB_reset(user_reset),

        .MB_address(mb_address),
        .MB_sel_0(mb_reg_sel_0),
        .MB_sel_1(mb_reg_sel_1),
        .MB_sel_2(mb_reg_sel_2),
        .MB_sel_3(mb_reg_sel_3),
        .MB_sel_4(mb_reg_sel_4),
        .MB_sel_5(mb_reg_sel_5),
        .MB_sel_6(mb_reg_sel_6),
        .MB_sel_7(mb_reg_sel_7),
        .MB_sel_8(mb_reg_sel_8),
        .MB_sel_9(mb_reg_sel_9),
        .MB_sel_10(mb_reg_sel_10),
        .MB_sel_11(mb_reg_sel_11),
        .MB_sel_12(mb_reg_sel_12),
        .MB_sel_13(mb_reg_sel_13),
        .MB_sel_14(mb_reg_sel_14),
        .MB_sel_15(mb_reg_sel_15),   

        .MB_write_strobe(mb_wr),
        .MB_read_strobe(mb_rd),
        .MB_data_in(mb_data_in),

        .MB_data_out(mb_data_out),
        .MB_done(mb_done)
    );
	
//    slave i_slave_1 (
//        .MB_clock(mb_clock),
//        .MB_reset(user_reset),
//
//        .MB_sel_reg(mb_reg_sel_1),
//        .MB_write_strobe(mb_wr),
//        .MB_read_strobe(mb_rd),
//        .MB_address(mb_address),
//        .MB_data_in(mb_data_in),
//        .MB_data_out(mb_data_out_1),
//        .MB_done(mb_done_1)
//    );    
//
//    slave i_slave_2 (
//        .MB_clock(mb_clock),
//        .MB_reset(user_reset),
//
//        .MB_sel_reg(mb_reg_sel_2),
//        .MB_write_strobe(mb_wr),
//        .MB_read_strobe(mb_rd),
//        .MB_address(mb_address),
//        .MB_data_in(mb_data_in),
//        .MB_data_out(mb_data_out_2),
//        .MB_done(mb_done_2)
//    );
//
//    slave i_slave_3 (
//        .MB_clock(mb_clock),
//        .MB_reset(user_reset),
//
//        .MB_sel_reg(mb_reg_sel_3),
//        .MB_write_strobe(mb_wr),
//        .MB_read_strobe(mb_rd),
//        .MB_address(mb_address),
//        .MB_data_in(mb_data_in),
//        .MB_data_out(mb_data_out_3),
//        .MB_done(mb_done_3)
//    );
//
//    slave i_slave_4 (
//        .MB_clock(mb_clock),
//        .MB_reset(user_reset),
//
//        .MB_sel_reg(mb_reg_sel_4),
//        .MB_write_strobe(mb_wr),
//        .MB_read_strobe(mb_rd),
//        .MB_address(mb_address),
//        .MB_data_in(mb_data_in),
//        .MB_data_out(mb_data_out_4),
//        .MB_done(mb_done_4)
//    );    
//
//    slave i_slave_5 (
//        .MB_clock(mb_clock),
//        .MB_reset(user_reset),
//
//        .MB_sel_reg(mb_reg_sel_5),
//        .MB_write_strobe(mb_wr),
//        .MB_read_strobe(mb_rd),
//        .MB_address(mb_address),
//        .MB_data_in(mb_data_in),
//        .MB_data_out(mb_data_out_5),
//        .MB_done(mb_done_5)
//    );    
//
//    slave i_slave_6 (
//        .MB_clock(mb_clock),
//        .MB_reset(user_reset),
//
//        .MB_sel_reg(mb_reg_sel_6),
//        .MB_write_strobe(mb_wr),
//        .MB_read_strobe(mb_rd),
//        .MB_address(mb_address),
//        .MB_data_in(mb_data_in),
//        .MB_data_out(mb_data_out_6),
//        .MB_done(mb_done_6)
//    );
//
//    slave i_slave_7 (
//        .MB_clock(mb_clock),
//        .MB_reset(user_reset),
//
//        .MB_sel_reg(mb_reg_sel_7),
//        .MB_write_strobe(mb_wr),
//        .MB_read_strobe(mb_rd),
//        .MB_address(mb_address),
//        .MB_data_in(mb_data_in),
//        .MB_data_out(mb_data_out_7),
//        .MB_done(mb_done_7)
//    );	 
//    
//    slave i_slave_8 (
//        .MB_clock(mb_clock),
//        .MB_reset(user_reset),
//
//        .MB_sel_reg(mb_reg_sel_8),
//        .MB_write_strobe(mb_wr),
//        .MB_read_strobe(mb_rd),
//        .MB_address(mb_address),
//        .MB_data_in(mb_data_in),
//        .MB_data_out(mb_data_out_8),
//        .MB_done(mb_done_8)
//    );    
//	 
//    slave i_slave_9 (
//        .MB_clock(mb_clock),
//        .MB_reset(user_reset),
//
//        .MB_sel_reg(mb_reg_sel_9),
//        .MB_write_strobe(mb_wr),
//        .MB_read_strobe(mb_rd),
//        .MB_address(mb_address),
//        .MB_data_in(mb_data_in),
//        .MB_data_out(mb_data_out_9),
//        .MB_done(mb_done_9)
//    );    
//
//    slave i_slave_10 (
//        .MB_clock(mb_clock),
//        .MB_reset(user_reset),
//
//        .MB_sel_reg(mb_reg_sel_10),
//        .MB_write_strobe(mb_wr),
//        .MB_read_strobe(mb_rd),
//        .MB_address(mb_address),
//        .MB_data_in(mb_data_in),
//        .MB_data_out(mb_data_out_10),
//        .MB_done(mb_done_10)
//    );    
//
//    slave i_slave_11 (
//        .MB_clock(mb_clock),
//        .MB_reset(user_reset),
//
//        .MB_sel_reg(mb_reg_sel_11),
//        .MB_write_strobe(mb_wr),
//        .MB_read_strobe(mb_rd),
//        .MB_address(mb_address),
//        .MB_data_in(mb_data_in),
//        .MB_data_out(mb_data_out_11),
//        .MB_done(mb_done_11)
//    );
//
//    slave i_slave_12 (
//        .MB_clock(mb_clock),
//        .MB_reset(user_reset),
//
//        .MB_sel_reg(mb_reg_sel_12),
//        .MB_write_strobe(mb_wr),
//        .MB_read_strobe(mb_rd),
//        .MB_address(mb_address),
//        .MB_data_in(mb_data_in),
//        .MB_data_out(mb_data_out_12),
//        .MB_done(mb_done_12)
//    );
//
//    slave i_slave_13 (
//        .MB_clock(mb_clock),
//        .MB_reset(user_reset),
//
//        .MB_sel_reg(mb_reg_sel_13),
//        .MB_write_strobe(mb_wr),
//        .MB_read_strobe(mb_rd),
//        .MB_address(mb_address),
//        .MB_data_in(mb_data_in),
//        .MB_data_out(mb_data_out_13),
//        .MB_done(mb_done_13)
//    );    
//
//    slave i_slave_14 (
//        .MB_clock(mb_clock),
//        .MB_reset(user_reset),
//
//        .MB_sel_reg(mb_reg_sel_14),
//        .MB_write_strobe(mb_wr),
//        .MB_read_strobe(mb_rd),
//        .MB_address(mb_address),
//        .MB_data_in(mb_data_in),
//        .MB_data_out(mb_data_out_14),
//        .MB_done(mb_done_14)
//    );    
//
//    slave i_slave_15 (
//        .MB_clock(mb_clock),
//        .MB_reset(user_reset),
//
//        .MB_sel_reg(mb_reg_sel_15),
//        .MB_write_strobe(mb_wr),
//        .MB_read_strobe(mb_rd),
//        .MB_address(mb_address),
//        .MB_data_in(mb_data_in),
//        .MB_data_out(mb_data_out_15),
//        .MB_done(mb_done_15)
//    );
    
    assign mb_data_out = (mb_reg_sel_0==1 & mb_reg_sel_1==0 & 
								  mb_reg_sel_2==0 & mb_reg_sel_3==0 &
								  mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
								  mb_reg_sel_6==0 & mb_reg_sel_7==0 &
								  mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
								  mb_reg_sel_10==0 & mb_reg_sel_11==0 &
								  mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
								  mb_reg_sel_14==0 & mb_reg_sel_15==0)
								  ? mb_data_out_0:
								 (mb_reg_sel_0==0 & mb_reg_sel_1==1 & 
								  mb_reg_sel_2==0 & mb_reg_sel_3==0 &
								  mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
								  mb_reg_sel_6==0 & mb_reg_sel_7==0 &
								  mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
								  mb_reg_sel_10==0 & mb_reg_sel_11==0 &
								  mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
								  mb_reg_sel_14==0 & mb_reg_sel_15==0)
								  ? mb_data_out_1:
								 (mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
								  mb_reg_sel_2==1 & mb_reg_sel_3==0 &
								  mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
								  mb_reg_sel_6==0 & mb_reg_sel_7==0 &
								  mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
								  mb_reg_sel_10==0 & mb_reg_sel_11==0 &
								  mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
								  mb_reg_sel_14==0 & mb_reg_sel_15==0)
								  ? mb_data_out_2:
								 (mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
								  mb_reg_sel_2==0 & mb_reg_sel_3==1 &
								  mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
								  mb_reg_sel_6==0 & mb_reg_sel_7==0 &
								  mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
								  mb_reg_sel_10==0 & mb_reg_sel_11==0 &
								  mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
								  mb_reg_sel_14==0 & mb_reg_sel_15==0)
								  ? mb_data_out_3:
								 (mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
								  mb_reg_sel_2==0 & mb_reg_sel_3==0 &
								  mb_reg_sel_4==1 & mb_reg_sel_5==0 & 
								  mb_reg_sel_6==0 & mb_reg_sel_7==0 &
								  mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
								  mb_reg_sel_10==0 & mb_reg_sel_11==0 &
								  mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
								  mb_reg_sel_14==0 & mb_reg_sel_15==0)
								  ? mb_data_out_4:
								 (mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
								  mb_reg_sel_2==0 & mb_reg_sel_3==0 &
								  mb_reg_sel_4==0 & mb_reg_sel_5==1 & 
								  mb_reg_sel_6==0 & mb_reg_sel_7==0 &
								  mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
								  mb_reg_sel_10==0 & mb_reg_sel_11==0 &
								  mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
								  mb_reg_sel_14==0 & mb_reg_sel_15==0)
								  ? mb_data_out_5:
								 (mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
								  mb_reg_sel_2==0 & mb_reg_sel_3==0 &
								  mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
								  mb_reg_sel_6==1 & mb_reg_sel_7==0 &
								  mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
								  mb_reg_sel_10==0 & mb_reg_sel_11==0 &
								  mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
								  mb_reg_sel_14==0 & mb_reg_sel_15==0)
								  ? mb_data_out_6:
								 (mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
								  mb_reg_sel_2==0 & mb_reg_sel_3==0 &
								  mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
								  mb_reg_sel_6==0 & mb_reg_sel_7==1 &
								  mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
								  mb_reg_sel_10==0 & mb_reg_sel_11==0 &
								  mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
								  mb_reg_sel_14==0 & mb_reg_sel_15==0)
								  ? mb_data_out_7: 								  
								 (mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
								  mb_reg_sel_2==0 & mb_reg_sel_3==0 &
								  mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
								  mb_reg_sel_6==0 & mb_reg_sel_7==0 &
								  mb_reg_sel_8==1 & mb_reg_sel_9==0 & 
								  mb_reg_sel_10==0 & mb_reg_sel_11==0 &
								  mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
								  mb_reg_sel_14==0 & mb_reg_sel_15==0)
								  ? mb_data_out_8:
								 (mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
								  mb_reg_sel_2==0 & mb_reg_sel_3==0 &
								  mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
								  mb_reg_sel_6==0 & mb_reg_sel_7==0 &
								  mb_reg_sel_8==0 & mb_reg_sel_9==1 & 
								  mb_reg_sel_10==0 & mb_reg_sel_11==0 &
								  mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
								  mb_reg_sel_14==0 & mb_reg_sel_15==0)
								  ? mb_data_out_9:
								 (mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
								  mb_reg_sel_2==0 & mb_reg_sel_3==0 &
								  mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
								  mb_reg_sel_6==0 & mb_reg_sel_7==0 &
								  mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
								  mb_reg_sel_10==1 & mb_reg_sel_11==0 &
								  mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
								  mb_reg_sel_14==0 & mb_reg_sel_15==0)
								  ? mb_data_out_10:
								 (mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
								  mb_reg_sel_2==0 & mb_reg_sel_3==0 &
								  mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
								  mb_reg_sel_6==0 & mb_reg_sel_7==0 &
								  mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
								  mb_reg_sel_10==0 & mb_reg_sel_11==1 &
								  mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
								  mb_reg_sel_14==0 & mb_reg_sel_15==0)
								  ? mb_data_out_11:
								 (mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
								  mb_reg_sel_2==0 & mb_reg_sel_3==0 &
								  mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
								  mb_reg_sel_6==0 & mb_reg_sel_7==0 &
								  mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
								  mb_reg_sel_10==0 & mb_reg_sel_11==0 &
								  mb_reg_sel_12==1 & mb_reg_sel_13==0 & 
								  mb_reg_sel_14==0 & mb_reg_sel_15==0)
								  ? mb_data_out_12:
								 (mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
								  mb_reg_sel_2==0 & mb_reg_sel_3==0 &
								  mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
								  mb_reg_sel_6==0 & mb_reg_sel_7==0 &
								  mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
								  mb_reg_sel_10==0 & mb_reg_sel_11==0 &
								  mb_reg_sel_12==0 & mb_reg_sel_13==1 & 
								  mb_reg_sel_14==0 & mb_reg_sel_15==0)
								  ? mb_data_out_13:
								 (mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
								  mb_reg_sel_2==0 & mb_reg_sel_3==0 &
								  mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
								  mb_reg_sel_6==0 & mb_reg_sel_7==0 &
								  mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
								  mb_reg_sel_10==0 & mb_reg_sel_11==0 &
								  mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
								  mb_reg_sel_14==1 & mb_reg_sel_15==0)
								  ? mb_data_out_14:
								 (mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
								  mb_reg_sel_2==0 & mb_reg_sel_3==0 &
								  mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
								  mb_reg_sel_6==0 & mb_reg_sel_7==0 &
								  mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
								  mb_reg_sel_10==0 & mb_reg_sel_11==0 &
								  mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
								  mb_reg_sel_14==0 & mb_reg_sel_15==1)
								  ? mb_data_out_15: 								  								  
								  0;
				 
    assign mb_done = (mb_reg_sel_0==1 & mb_reg_sel_1==0 & 
							 mb_reg_sel_2==0 & mb_reg_sel_3==0 &
							 mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
							 mb_reg_sel_6==0 & mb_reg_sel_7==0 &
							 mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
							 mb_reg_sel_10==0 & mb_reg_sel_11==0 &
							 mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
							 mb_reg_sel_14==0 & mb_reg_sel_15==0) 
							 ? mb_done_0:
							(mb_reg_sel_0==0 & mb_reg_sel_1==1 & 
							 mb_reg_sel_2==0 & mb_reg_sel_3==0 &
							 mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
							 mb_reg_sel_6==0 & mb_reg_sel_7==0 &
							 mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
							 mb_reg_sel_10==0 & mb_reg_sel_11==0 &
							 mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
							 mb_reg_sel_14==0 & mb_reg_sel_15==0) 
							 ? mb_done_1:
							(mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
							 mb_reg_sel_2==1 & mb_reg_sel_3==0 &
							 mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
							 mb_reg_sel_6==0 & mb_reg_sel_7==0 &
							 mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
							 mb_reg_sel_10==0 & mb_reg_sel_11==0 &
							 mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
							 mb_reg_sel_14==0 & mb_reg_sel_15==0) 
							 ? mb_done_2:
							(mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
							 mb_reg_sel_2==0 & mb_reg_sel_3==1 &
							 mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
							 mb_reg_sel_6==0 & mb_reg_sel_7==0 &
							 mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
							 mb_reg_sel_10==0 & mb_reg_sel_11==0 &
							 mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
							 mb_reg_sel_14==0 & mb_reg_sel_15==0) 
							 ? mb_done_3:
							(mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
							 mb_reg_sel_2==0 & mb_reg_sel_3==0 &
							 mb_reg_sel_4==1 & mb_reg_sel_5==0 & 
							 mb_reg_sel_6==0 & mb_reg_sel_7==0 &
							 mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
							 mb_reg_sel_10==0 & mb_reg_sel_11==0 &
							 mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
							 mb_reg_sel_14==0 & mb_reg_sel_15==0) 
							 ? mb_done_4:
							(mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
							 mb_reg_sel_2==0 & mb_reg_sel_3==0 &
							 mb_reg_sel_4==0 & mb_reg_sel_5==1 & 
							 mb_reg_sel_6==0 & mb_reg_sel_7==0 &
							 mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
							 mb_reg_sel_10==0 & mb_reg_sel_11==0 &
							 mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
							 mb_reg_sel_14==0 & mb_reg_sel_15==0) 
							 ? mb_done_5:
							(mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
							 mb_reg_sel_2==0 & mb_reg_sel_3==0 &
							 mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
							 mb_reg_sel_6==1 & mb_reg_sel_7==0 &
							 mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
							 mb_reg_sel_10==0 & mb_reg_sel_11==0 &
							 mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
							 mb_reg_sel_14==0 & mb_reg_sel_15==0) 
							 ? mb_done_6:
							(mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
							 mb_reg_sel_2==0 & mb_reg_sel_3==0 &
							 mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
							 mb_reg_sel_6==0 & mb_reg_sel_7==1 &
							 mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
							 mb_reg_sel_10==0 & mb_reg_sel_11==0 &
							 mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
							 mb_reg_sel_14==0 & mb_reg_sel_15==0) 
							 ? mb_done_7:
							(mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
							 mb_reg_sel_2==0 & mb_reg_sel_3==0 &
							 mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
							 mb_reg_sel_6==0 & mb_reg_sel_7==0 &
							 mb_reg_sel_8==1 & mb_reg_sel_9==0 & 
							 mb_reg_sel_10==0 & mb_reg_sel_11==0 &
							 mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
							 mb_reg_sel_14==0 & mb_reg_sel_15==0) 
							 ? mb_done_8:
							(mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
							 mb_reg_sel_2==0 & mb_reg_sel_3==0 &
							 mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
							 mb_reg_sel_6==0 & mb_reg_sel_7==0 &
							 mb_reg_sel_8==0 & mb_reg_sel_9==1 & 
							 mb_reg_sel_10==0 & mb_reg_sel_11==0 &
							 mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
							 mb_reg_sel_14==0 & mb_reg_sel_15==0) 
							 ? mb_done_9:
							(mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
							 mb_reg_sel_2==0 & mb_reg_sel_3==0 &
							 mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
							 mb_reg_sel_6==0 & mb_reg_sel_7==0 &
							 mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
							 mb_reg_sel_10==1 & mb_reg_sel_11==0 &
							 mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
							 mb_reg_sel_14==0 & mb_reg_sel_15==0) 
							 ? mb_done_10:
							(mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
							 mb_reg_sel_2==0 & mb_reg_sel_3==0 &
							 mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
							 mb_reg_sel_6==0 & mb_reg_sel_7==0 &
							 mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
							 mb_reg_sel_10==0 & mb_reg_sel_11==1 &
							 mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
							 mb_reg_sel_14==0 & mb_reg_sel_15==0) 
							 ? mb_done_11:
							(mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
							 mb_reg_sel_2==0 & mb_reg_sel_3==0 &
							 mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
							 mb_reg_sel_6==0 & mb_reg_sel_7==0 &
							 mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
							 mb_reg_sel_10==0 & mb_reg_sel_11==0 &
							 mb_reg_sel_12==1 & mb_reg_sel_13==0 & 
							 mb_reg_sel_14==0 & mb_reg_sel_15==0) 
							 ? mb_done_12:
							(mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
							 mb_reg_sel_2==0 & mb_reg_sel_3==0 &
							 mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
							 mb_reg_sel_6==0 & mb_reg_sel_7==0 &
							 mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
							 mb_reg_sel_10==0 & mb_reg_sel_11==0 &
							 mb_reg_sel_12==0 & mb_reg_sel_13==1 & 
							 mb_reg_sel_14==0 & mb_reg_sel_15==0) 
							 ? mb_done_13:
							(mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
							 mb_reg_sel_2==0 & mb_reg_sel_3==0 &
							 mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
							 mb_reg_sel_6==0 & mb_reg_sel_7==0 &
							 mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
							 mb_reg_sel_10==0 & mb_reg_sel_11==0 &
							 mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
							 mb_reg_sel_14==1 & mb_reg_sel_15==0) 
							 ? mb_done_14:
							(mb_reg_sel_0==0 & mb_reg_sel_1==0 & 
							 mb_reg_sel_2==0 & mb_reg_sel_3==0 &
							 mb_reg_sel_4==0 & mb_reg_sel_5==0 & 
							 mb_reg_sel_6==0 & mb_reg_sel_7==0 &
							 mb_reg_sel_8==0 & mb_reg_sel_9==0 & 
							 mb_reg_sel_10==0 & mb_reg_sel_11==0 &
							 mb_reg_sel_12==0 & mb_reg_sel_13==0 & 
							 mb_reg_sel_14==0 & mb_reg_sel_15==1) 
							 ? mb_done_15:
							 0;				 
 
endmodule

