------------------------------------------------- 
-- MSXPi2 demonstration
-- Simulate a MSX ROM cartridge
-- Ronivon Costa, July 2020.
-- On boot, print "MSXPI" and halts the computer. 
------------------------------------------------- 
library ieee;
use ieee.std_logic_1164.all;
library altera;
use altera.altera_syn_attributes.all;

entity MSXPi2_ROM is
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
		--GPIO_D[0] : inout std_logic; -- D0 / GPIO_26 / BCM26
		--GPIO_D[1] : inout std_logic; -- D1 / GPIO_27 / BCM27
		--GPIO_D[2] : inout std_logic; -- D2 / GPIO_2 / BCM2
		--GPIO_D[3] : inout std_logic; -- D3 / GPIO_3 / BCM3
		--GPIO_D[4] : inout std_logic; -- D4 / GPIO_4 / BCM4
		--GPIO_D[5] : inout std_logic; -- D5 / GPIO_5 / BCM5
		--GPIO_D[6] : inout std_logic; -- D6 / GPIO_6 / BCM6
		--GPIO_D[7] : inout std_logic; -- D7 / GPIO_7 / BCM7
		--GPIO_A[0] : out std_logic; -- A0 / GPIO_8 / BCM8
		--GPIO_A[1] : out std_logic; -- A1 / GPIO_9 / BCM9
		--GPIO_A[2] : out std_logic; -- A2 / GPIO_10 / BCM10
		--GPIO_A[3] : out std_logic; -- A3 / GPIO_11 / BCM11
		--GPIO_A[4] : out std_logic; -- A4 / GPIO_12 / BCM12
		--GPIO_A[5] : out std_logic; -- A5 / GPIO_13 / BCM13
		--GPIO_A[6] : out std_logic; -- A6 / GPIO_14 / BCM14
		--GPIO_A[7] : out std_logic; -- A7 / GPIO_15 / BCM15
		--GPIO_A[8] : out std_logic; -- A8 / GPIO_16 / BCM16
		--GPIO_A[9] : out std_logic; -- A9 / GPIO_17 / BCM17
		--GPIO_A[10] : out std_logic; -- A10 / GPIO_18 / BCM18
		--GPIO_A[11] : out std_logic; -- A11 / GPIO_19 / BCM19
		--GPIO_A[12] : out std_logic; -- A12 / GPIO_20 / BCM20
		--GPIO_A[13] : out std_logic; -- A13 / GPIO_22 / BCM22
		
		rpi_cs : out std_logic; -- RPI CS signal - send interrupt to RPi - GPIO_21 / BCM21
		rpi_wr : out std_logic; -- MSX access type: 1 = read, 0 = write - GPIO_23 / BCM23
		rpi_io : out std_logic; -- MSX IO type: 1 = port access, 0 = memory access - GPIO_24 / BCM24
		rpi_rdy : in std_logic; -- RPI_ready - GPIO_25 / BCM25
		GPIO_0 : in std_logic; -- BCM0
		GPIO_1 : in std_logic  -- BCM1
		
	);

end MSXPi2_ROM;

architecture ppl_type of MSXPi2_ROM is

    signal led_s: std_logic;
	signal access_s: std_logic;
	signal msxpi_en_s: std_logic;
	signal d_s: std_logic_vector(7 downto 0);
begin

   rpi_cs <= '1' when SLTSL = '0' and RD_n = '0' else '0';
   WAIT_n <= rpi_rdy;
				 
   BDIR <= 'Z';

	D <= d_s when SLTSL = '0' and RD_n = '0' else (others => 'Z');
	
   GPIO_D <= d_s;
	GPIO_A <= A(13 downto 0);
	rpi_wr <= WR_n;
	rpi_io <= MREQ_n;
	
-- This following process implements a rom memory, containing this Z80 code:
--
-- CHPUT: EQU $A2
-- 	org $4000
-- 	db "AB"
-- 	dw INIT
-- 	db "MSXPi2 CPLD TST"
-- INIT:
-- 	ld a,'M'
-- 	call CHPUT
-- 	ld a,'S'
-- 	call CHPUT
-- 	ld a,'X'
-- 	call CHPUT
-- 	ld a,'P'
-- 	call CHPUT
-- 	ld a,'I'
-- 	call CHPUT
-- 	halt
	
	process(SLTSL)
	begin
	    if (SLTSL'event and SLTSL = '0') then
			 case A is
				when x"4000" =>
					d_s <= x"41";
				when x"4001" =>
					d_s <= x"42";
				when x"4002" =>
					d_s <= x"13";
				when x"4003" =>
					d_s <= x"40";
				when x"4004" =>
					d_s <= x"4D";
				when x"4005" =>
					d_s <= x"53";
				when x"4006" =>
					d_s <= x"58";
				when x"4007" =>
					d_s <= x"50";
				when x"4008" =>
					d_s <= x"69";
				when x"4009" =>
					d_s <= x"32";
				when x"400A" =>
					d_s <= x"20";
				when x"400B" =>
					d_s <= x"43";
				when x"400C" =>
					d_s <= x"50";
				when x"400D" =>
					d_s <= x"4C";
				when x"400E" =>
					d_s <= x"44";
				when x"400F" =>
					d_s <= x"20";
				when x"4010" =>
					d_s <= x"54";
				when x"4011" =>
					d_s <= x"53";
				when x"4012" =>
					d_s <= x"54";
				when x"4013" =>
					d_s <= x"3E";
				when x"4014" =>
					d_s <= x"4D";
				when x"4015" =>
					d_s <= x"CD";
				when x"4016" =>
					d_s <= x"A2";
				when x"4017" =>
					d_s <= x"00";
				when x"4018" =>
					d_s <= x"3E";
				when x"4019" =>
					d_s <= x"53";
				when x"401A" =>
					d_s <= x"CD";
				when x"401B" =>
					d_s <= x"A2";
				when x"401C" =>
					d_s <= x"00";
				when x"401D" =>
					d_s <= x"3E";
				when x"401E" =>
					d_s <= x"58";
				when x"401F" =>
					d_s <= x"CD";
				when x"4020" =>
					d_s <= x"A2";
				when x"4021" =>
					d_s <= x"00";				
				when x"4022" =>
					d_s <= x"3E";
				when x"4023" =>
					d_s <= x"50";	
				when x"4024" =>
					d_s <= x"CD";	
				when x"4025" =>
					d_s <= x"A2";	
				when x"4026" =>
					d_s <= x"00";	
				when x"4027" =>
					d_s <= x"3E";	
				when x"4028" =>
					d_s <= x"49";	
				when x"4029" =>
					d_s <= x"CD";	
				when x"402A" =>
					d_s <= x"A2";	
				when x"402B" =>
					d_s <= x"00";	
				when x"402C" =>
					d_s <= x"76";	
				when x"402D" =>
					d_s <= x"00";	
				when OTHERS =>
				   d_s <= x"00";
			end case;
		end if;
	end process;
	
end;



