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

entity MSXPi2 is
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
		GPIO_D : inout std_logic_vector(7 downto 0);
		GPIO_A : out std_logic_vector(13 downto 0);
		--GPIO_D[0] : inout std_logic; -- D0 / GPIO_0
		--GPIO_D[1] : inout std_logic; -- D1 / GPIO_1
		--GPIO_D[2] : inout std_logic; -- D2 / GPIO_2
		--GPIO_D[3] : inout std_logic; -- D3 / GPIO_3
		--GPIO_D[4] : inout std_logic; -- D4 / GPIO_4
		--GPIO_D[5] : inout std_logic; -- D5 / GPIO_5
		--GPIO_D[6] : inout std_logic; -- D6 / GPIO_6
		--GPIO_D[7] : inout std_logic; -- D7 / GPIO_7
		--GPIO_A[0] : out std_logic; -- A0 / GPIO_8
		--GPIO_A[1] : out std_logic; -- A1 / GPIO_9
		--GPIO_A[2] : out std_logic; -- A2 / GPIO_10
		--GPIO_A[3] : out std_logic; -- A3 / GPIO_11
		--GPIO_A[4] : out std_logic; -- A4 / GPIO_12
		--GPIO_A[5] : out std_logic; -- A5 / GPIO_13
		--GPIO_A[6] : out std_logic; -- A6 / GPIO_14
		--GPIO_A[7] : out std_logic; -- A7 / GPIO_15
		--GPIO_A[8] : out std_logic; -- A8 / GPIO_16
		--GPIO_A[9] : out std_logic; -- A9 / GPIO_17
		--GPIO_A[10] : out std_logic; -- A10 / GPIO_18
		--GPIO_A[11] : out std_logic; -- A11 / GPIO_19
		--GPIO_A[12] : out std_logic; -- A12 / GPIO_20
		--GPIO_A[13] : out std_logic; -- A13 / GPIO_22
		
		GPIO_21 : out std_logic; -- RPI CS signal - send interrupt ro RPi
		GPIO_23 : out std_logic; -- MSX access type: 1 = read, 0 = write
		GPIO_24 : out std_logic; -- MSX IO type: 1 = port access, 0 = memory access
		GPIO_25 : in std_logic; -- RPI_ready
		GPIO_26 : in std_logic; -- 
		GPIO_27 : in std_logic  --
	);

end MSXPi2;

architecture ppl_type of MSXPi2 is

    signal led_s: std_logic;
	 signal access_s: std_logic;
	 signal msxpi_en_s: std_logic;
	 signal d_s: std_logic_vector(7 downto 0);
begin

   D <= d_s;
   
	WAIT_n <= sltsl or GPIO_25;
	BDIR <= 'Z';
	
	GPIO_23 <= not sltsl; =	-- RPI CS signal - send interrupt ro RPi
	GPIO_23 <= WR_n;			-- 1 = read, 0 = write
   GPIO_24 <= MREQ_n;		-- 1 = port access, 0 = memory access

end;



