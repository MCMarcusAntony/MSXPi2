-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

library ieee;
use ieee.std_logic_1164.all;
library altera;
use altera.altera_syn_attributes.all;

entity MSXPi2_Interface_Test is
	port
	(

	   -- CPLD programming pins
		--TCK : in std_logic;
		--TDI : in std_logic;
		--TDO : out std_logic;
		--TMS : in std_logic;

		-- MSX Bus signals
		D : inout std_logic_vector(7 downto 0);
		A : in std_logic_vector(15 downto 0);
		RD_n : in std_logic;
		WR_n : in std_logic;
		MREQ_n : in std_logic;
		IORQ_n : in std_logic;
		BDIR : out std_logic;
		M1 : in std_logic;
		SLTSL : in std_logic;
		WAIT_n : out std_logic;
		
		-- Raspberry Pi GPIO
		GPIO_0 : in std_logic;
		GPIO_1 : in std_logic;
		GPIO_2 : in std_logic;
		GPIO_3 : in std_logic;
		GPIO_4 : in std_logic;
		GPIO_5 : in std_logic;
		GPIO_6 : in std_logic;
		GPIO_7 : in std_logic;
		GPIO_8 : in std_logic;
		GPIO_9 : in std_logic;
		GPIO_10 : in std_logic;
		GPIO_11 : in std_logic;
		GPIO_12 : in std_logic;
		GPIO_13 : in std_logic;
		GPIO_14 : in std_logic;
		GPIO_15 : in std_logic;
		GPIO_16 : in std_logic;
		GPIO_17 : in std_logic;
		GPIO_18 : in std_logic;
		GPIO_19 : in std_logic;
		GPIO_20 : in std_logic;
		GPIO_21 : out std_logic;
		GPIO_22 : in std_logic;
		GPIO_23 : in std_logic;
		GPIO_24 : in std_logic;
		GPIO_25 : in std_logic;
		GPIO_26 : in std_logic;
		GPIO_27 : in std_logic
	);

end MSXPi2_Interface_Test;

architecture ppl_type of MSXPi2_Interface_Test is

    signal led_s: std_logic;
	 signal access_s: std_logic;
	 signal msxpi_en_s: std_logic;
	 signal d_s: std_logic_vector(7 downto 0);
begin

   D <= d_s;
   GPIO_21 <= led_s;
	WAIT_n <= 'Z';
	BDIR <= 'Z';
	
	msxpi_en_s <= '1' when ((WR_n = '0' or RD_n = '0') and (IORQ_n = '0' or MREQ_n = '0')) else '0';
	
	d_s <= x"AA" when (A(7 downto 0)  = x"56")   and RD_n = '0' and  IORQ_n = '0' else
	     x"BB" when (A(15 downto 0) = x"9876") and RD_n = '0' and  MREQ_n = '0' else -- does not return the value!?
		  x"CC" when (A(15 downto 0) = x"A876") and RD_n = '0' and  MREQ_n = '0' else -- does not return the value!?
		  (others => 'Z');
	
	led_s <= '1' when A(7 downto 0) = x"56" and WR_n = '0' and IORQ_n = '0' else
	         '0' when A(7 downto 0) = x"57" and WR_n = '0' and IORQ_n = '0' else
				'1' when (A(15 downto 0) = x"9876") and WR_n = '0' and  MREQ_n = '0' else
				'0' when (A(15 downto 0) = x"A876") and RD_n = '0' and  MREQ_n = '0';


end;



