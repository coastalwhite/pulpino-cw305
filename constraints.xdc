create_clock -period 50.000 -name clk [get_nets clk]
create_clock -period 50.000 -name clk [get_nets clk_glitch]
create_clock -period 40.000 -name spi_sck  [get_nets {spi_clk_i}]
create_clock -period 40.000 -name tck [get_nets tck_i]

# define false paths between all clocks
set_clock_groups -asynchronous \
                 -group { clk } \
                 -group { spi_sck } \
                 -group { tck }

#Mem init

#IO PORTS FOR CW305

#Sys Clock
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets tck_i_IBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets spi_clk_i_IBUF]
set_property -dict {PACKAGE_PIN E12 IOSTANDARD LVCMOS33} [get_ports clk]

#Glitch clk
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports clk_glitch]

set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS33} [get_ports clk_o]

# Sys Reset
set_property -dict {PACKAGE_PIN R1 IOSTANDARD LVCMOS33} [get_ports rst_n]

# UART
set_property -dict {PACKAGE_PIN B12 IOSTANDARD LVCMOS33} [get_ports uart_tx]
set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33} [get_ports uart_rx]
set_property -dict {PACKAGE_PIN B15 IOSTANDARD LVCMOS33} [get_ports uart_rts]
set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVCMOS33} [get_ports uart_dtr]
set_property -dict {PACKAGE_PIN C14 IOSTANDARD LVCMOS33} [get_ports uart_cts]
set_property -dict {PACKAGE_PIN C16 IOSTANDARD LVCMOS33} [get_ports uart_dsr]

#Debug
set_property -dict {PACKAGE_PIN D16 IOSTANDARD LVCMOS33} [get_ports tck_i]
set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS33} [get_ports trstn_i]
set_property -dict {PACKAGE_PIN F12 IOSTANDARD LVCMOS33} [get_ports tms_i]
set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports tdi_i]
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS33} [get_ports tdo_o]

#GPIO
set_property -dict {PACKAGE_PIN A12 IOSTANDARD LVCMOS33} [get_ports gpio_in_0]
set_property -dict {PACKAGE_PIN A14 IOSTANDARD LVCMOS33} [get_ports gpio_out_0]
#set_property -dict {PACKAGE_PIN A15 IOSTANDARD LVCMOS33} [get_ports gpio_dir_0]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports gpio_in_2]
set_property -dict {PACKAGE_PIN B2 IOSTANDARD LVCMOS33} [get_ports gpio_out_2]
set_property -dict {PACKAGE_PIN E13 IOSTANDARD LVCMOS33} [get_ports gpio_in_3]
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS33} [get_ports gpio_out_3]
set_property -dict {PACKAGE_PIN D15 IOSTANDARD LVCMOS33} [get_ports gpio_in_6]
set_property -dict {PACKAGE_PIN E15 IOSTANDARD LVCMOS33} [get_ports gpio_out_6]

# GPIO signal trigger
set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS33} [get_ports gpio_out_4]
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports gpio_out_5]

#GPIO - LED on board
set_property -dict {PACKAGE_PIN T3 IOSTANDARD LVCMOS33} [get_ports gpio_in_1]
set_property -dict {PACKAGE_PIN T4 IOSTANDARD LVCMOS33} [get_ports gpio_out_1]
set_property -dict {PACKAGE_PIN T2 IOSTANDARD LVCMOS33} [get_ports gpio_dir_1]

#SPI - Master
#set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports spi_master_clk_o]
#set_property -dict {PACKAGE_PIN B14 IOSTANDARD LVCMOS33} [get_ports spi_master_sdo0_o]
#set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS33} [get_ports spi_master_sdi0_i]
#set_property -dict {PACKAGE_PIN C13 IOSTANDARD LVCMOS33} [get_ports spi_master_csn0_o]
#set_property -dict {PACKAGE_PIN D13 IOSTANDARD LVCMOS33} [get_ports spi_master_csn1_o]

#SPI - Slave Debug
#set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports spi_clk_i]
#set_property -dict {PACKAGE_PIN A15 IOSTANDARD LVCMOS33} [get_ports spi_cs_i]
#set_property -dict {PACKAGE_PIN B14 IOSTANDARD LVCMOS33} [get_ports spi_sdo0_o]
#set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS33} [get_ports spi_sdi0_i]
set_property -dict {PACKAGE_PIN D6 IOSTANDARD LVCMOS33} [get_ports spi_clk_i]
set_property -dict {PACKAGE_PIN C7 IOSTANDARD LVCMOS33} [get_ports spi_cs_i]
set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports spi_sdo0_o]
set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVCMOS33} [get_ports spi_sdi0_i]

#BOOT Selection S2
set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVCMOS33} [get_ports boot_sel_0]
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports boot_sel_1]
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports clk_sel]

create_property bmm_info_memory_device cell -type string

set_property bmm_info_memory_device {[ 0: 3][0:8191]} [get_cells pulpino_i/core_region_i/instr_mem/sp_ram_wrap_i/sp_ram_i/mem_reg_0_0]
set_property bmm_info_memory_device {[ 4: 7][0:8191]} [get_cells pulpino_i/core_region_i/instr_mem/sp_ram_wrap_i/sp_ram_i/mem_reg_0_1]
set_property bmm_info_memory_device {[ 8: 11][0:8191]} [get_cells pulpino_i/core_region_i/instr_mem/sp_ram_wrap_i/sp_ram_i/mem_reg_1_0]
set_property bmm_info_memory_device {[ 12: 15][0:8191]} [get_cells pulpino_i/core_region_i/instr_mem/sp_ram_wrap_i/sp_ram_i/mem_reg_1_1]
set_property bmm_info_memory_device {[ 16: 19][0:8191]} [get_cells pulpino_i/core_region_i/instr_mem/sp_ram_wrap_i/sp_ram_i/mem_reg_2_0]
set_property bmm_info_memory_device {[ 20: 23][0:8191]} [get_cells pulpino_i/core_region_i/instr_mem/sp_ram_wrap_i/sp_ram_i/mem_reg_2_1]
set_property bmm_info_memory_device {[ 24: 27][0:8191]} [get_cells pulpino_i/core_region_i/instr_mem/sp_ram_wrap_i/sp_ram_i/mem_reg_3_0]
set_property bmm_info_memory_device {[ 28: 31][0:8191]} [get_cells pulpino_i/core_region_i/instr_mem/sp_ram_wrap_i/sp_ram_i/mem_reg_3_1]

set_property bmm_info_memory_device {[ 0: 3][0:8191]} [get_cells pulpino_i/core_region_i/data_mem/sp_ram_i/mem_reg_0_0]
set_property bmm_info_memory_device {[ 4: 7][0:8191]} [get_cells pulpino_i/core_region_i/data_mem/sp_ram_i/mem_reg_0_1]
set_property bmm_info_memory_device {[ 8: 11][0:8191]} [get_cells pulpino_i/core_region_i/data_mem/sp_ram_i/mem_reg_1_0]
set_property bmm_info_memory_device {[ 12: 15][0:8191]} [get_cells pulpino_i/core_region_i/data_mem/sp_ram_i/mem_reg_1_1]
set_property bmm_info_memory_device {[ 16: 19][0:8191]} [get_cells pulpino_i/core_region_i/data_mem/sp_ram_i/mem_reg_2_0]
set_property bmm_info_memory_device {[ 20: 23][0:8191]} [get_cells pulpino_i/core_region_i/data_mem/sp_ram_i/mem_reg_2_1]
set_property bmm_info_memory_device {[ 24: 27][0:8191]} [get_cells pulpino_i/core_region_i/data_mem/sp_ram_i/mem_reg_3_0]
set_property bmm_info_memory_device {[ 28: 31][0:8191]} [get_cells pulpino_i/core_region_i/data_mem/sp_ram_i/mem_reg_3_1]