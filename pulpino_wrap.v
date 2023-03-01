// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

module pulpino(
  clk,
  clk_glitch,
  rst_n,

  //fetch_enable_i,

  spi_clk_i,
  spi_cs_i,
  //spi_mode_o,
  spi_sdo0_o,
  //spi_sdo1_o,
  //spi_sdo2_o,
  //spi_sdo3_o,
  spi_sdi0_i,
  //spi_sdi1_i,
  //spi_sdi2_i,
  //spi_sdi3_i,

  //spi_master_clk_o,
  //spi_master_csn0_o,
  //spi_master_csn1_o,
  //spi_master_sdo0_o,
  //spi_master_sdi0_i,

// Interface UART
  uart_tx,
  uart_rx,
  uart_rts,
  uart_dtr,
  uart_cts,
  uart_dsr,

/*  scl_i,
  scl_o,
  scl_oen_o,
  sda_i,
  sda_o,
  sda_oen_o,*/

// GPIO PORT
  gpio_in_0,
  gpio_out_0,
  //gpio_dir_0,
  gpio_in_1,
  gpio_out_1,
  gpio_dir_1,
  gpio_in_2,
  gpio_out_2,
  gpio_in_3,
  gpio_out_3,
  gpio_in_6,
  gpio_out_6,
  
  gpio_out_4,
  gpio_out_5,

// Debug PORT
  tck_i,
  trstn_i,
  tms_i,
  tdi_i,
  tdo_o,
  
  boot_sel_0,
  boot_sel_1,
  
  clk_sel,
  
  clk_o
  
  );

  // Clock and Reset
  input         clk;
  input         clk_glitch;
  input         rst_n;

  //input         fetch_enable_i;

  input         spi_clk_i;
  input         spi_cs_i;
  //output  [1:0] spi_mode_o;
  output        spi_sdo0_o;
  //output        spi_sdo1_o;
  //output        spi_sdo2_o;
  //output        spi_sdo3_o;
  input         spi_sdi0_i;
  //input         spi_sdi1_i;
  //input         spi_sdi2_i;
  //input         spi_sdi3_i;

  //output        spi_master_clk_o;
  //output        spi_master_csn0_o;
  //output        spi_master_csn1_o;
  //output        spi_master_sdo0_o;
  //input         spi_master_sdi0_i;

  output        uart_tx;
  input         uart_rx;
  output        uart_rts;
  output        uart_dtr;
  input         uart_cts;
  input         uart_dsr;

/*  input         scl_i;
  output        scl_o;
  output        scl_oen_o;
  input         sda_i;
  output        sda_o;
  output        sda_oen_o;*/

  input   gpio_in_0;
  output  gpio_out_0;
  //output  gpio_dir_0;
  
  input   gpio_in_1;
  output  gpio_out_1;
  output  gpio_dir_1;
  
  input   gpio_in_2;
  output  gpio_out_2;
  input   gpio_in_3;
  output  gpio_out_3;
  input   gpio_in_6;
  output  gpio_out_6;
  
  // trigger port
  output  gpio_out_4;
  output  gpio_out_5;
  

  // JTAG signals
  input  tck_i;
  input  trstn_i;
  input  tms_i;
  input  tdi_i;
  output tdo_o;
  
  // boot sel switcher
  input boot_sel_0;
  input boot_sel_1;
  
  input clk_sel;
  
  output clk_o;

  parameter USE_ZERO_RISCY = 0;
  parameter RISCY_RV32F = 0;
  parameter ZERO_RV32M = 0;
  parameter ZERO_RV32E = 0;
   
  reg clk_soc_i;
  
  wire [31:0] gpio_in;
  wire [31:0] gpio_out;
  wire [31:0] gpio_dir;
  
  wire clk_for_glitch;
  
  assign gpio_in_0 = gpio_in[0];
  assign gpio_out_0 = gpio_out[0];
  //assign gpio_dir_0 = gpio_dir[0];
  
  assign gpio_in_1 = gpio_in[1];
  assign gpio_out_1 = gpio_out[1];
  assign gpio_dir_1 = gpio_dir[1];
  assign gpio_in_2 = gpio_in[2];
  assign gpio_out_2 = gpio_out[2];
  assign gpio_in_3 = gpio_in[3];
  assign gpio_out_3 = gpio_out[3];
  assign gpio_in_6 = gpio_in[6];
  assign gpio_out_6 = gpio_out[6];
  
  //assign gpio_in_4 = gpio_in[4];
  assign gpio_out_4 = gpio_out[4];
  //assign gpio_in_5 = gpio_in[5];
  assign gpio_out_5 = gpio_out[5];
  
  assign clk_for_glitch = clk;
  assign clk_o = clk_for_glitch;
  
  always @(*)
  begin
    if(clk_sel == 1'b0)
        clk_soc_i = clk;
    else
        clk_soc_i = clk_glitch;
  end
  
  // PULP SoC
  pulpino_top
  #(
    .USE_ZERO_RISCY    ( USE_ZERO_RISCY ),
    .RISCY_RV32F       ( RISCY_RV32F    ),
    .ZERO_RV32M        ( ZERO_RV32M     ),
    .ZERO_RV32E        ( ZERO_RV32E     )
  )
  pulpino_i
  (
    //.clk               ( clk               ),
    .clk               ( clk_soc_i         ),
    .rst_n             ( rst_n             ),

    .clk_sel_i         ( 1'b0              ),
    .clk_standalone_i  ( 1'b0              ),

    .testmode_i        ( 1'b0              ),
    //.fetch_enable_i    ( fetch_enable_i    ),
    .fetch_enable_i    ( 1'b1              ),
    .scan_enable_i     ( 1'b0              ),

    .spi_clk_i         ( spi_clk_i         ),
    .spi_cs_i          ( spi_cs_i          ),
    //.spi_mode_o        ( spi_mode_o        ),
    .spi_sdo0_o        ( spi_sdo0_o        ),
    //.spi_sdo1_o        ( spi_sdo1_o        ),
    //.spi_sdo2_o        ( spi_sdo2_o        ),
    //.spi_sdo3_o        ( spi_sdo3_o        ),
    .spi_sdi0_i        ( spi_sdi0_i        ),
    //.spi_sdi1_i        ( spi_sdi1_i        ),
    //.spi_sdi2_i        ( spi_sdi2_i        ),
    //.spi_sdi3_i        ( spi_sdi3_i        ),
    
    // SPI master
    //.spi_master_clk_o  ( spi_master_clk_o  ),
    //.spi_master_csn0_o ( spi_master_csn0_o ),
    //.spi_master_csn1_o ( spi_master_csn1_o ),
    //.spi_master_csn2_o ( spi_master_csn2_o ),
    //.spi_master_csn3_o ( spi_master_csn3_o ),
    //.spi_master_mode_o ( spi_master_mode_o ),
    //.spi_master_sdo0_o ( spi_master_sdo0_o ),
    //.spi_master_sdo1_o ( spi_master_sdo1_o ),
    //.spi_master_sdo2_o ( spi_master_sdo2_o ),
    //.spi_master_sdo3_o ( spi_master_sdo3_o ),
    //.spi_master_sdi0_i ( spi_master_sdi0_i ),
    //.spi_master_sdi1_i ( spi_master_sdi1_i ),
    //.spi_master_sdi2_i ( spi_master_sdi2_i ),
    //.spi_master_sdi3_i ( spi_master_sdi3_i ),

    .uart_tx           ( uart_tx           ), // output
    .uart_rx           ( uart_rx           ), // input
    .uart_rts          ( uart_rts          ), // output
    .uart_dtr          ( uart_dtr          ), // output
    .uart_cts          ( uart_cts          ), // input
    .uart_dsr          ( uart_dsr          ), // input

/*    .scl_pad_i         ( scl_i             ),
    .scl_pad_o         ( scl_o             ),
    .scl_padoen_o      ( scl_oen_o         ),
    .sda_pad_i         ( sda_i             ),
    .sda_pad_o         ( sda_o             ),
    .sda_padoen_o      ( sda_oen_o         ),*/

    .gpio_in           ( gpio_in           ),
    .gpio_out          ( gpio_out          ),
    .gpio_dir          ( gpio_dir          ),
    .gpio_padcfg       (                   ),

    .tck_i             ( tck_i             ),
    .trstn_i           ( trstn_i           ),
    .tms_i             ( tms_i             ),
    .tdi_i             ( tdi_i             ),
    .tdo_o             ( tdo_o             ),

    .pad_cfg_o         (                   ),
    .pad_mux_o         (                   ),
  );

endmodule
