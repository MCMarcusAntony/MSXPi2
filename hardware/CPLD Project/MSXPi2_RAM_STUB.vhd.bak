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

end MSXPi2_ROM;

architecture ppl_type of MSXPi2_ROM is

    signal led_s: std_logic;
	 signal access_s: std_logic;
	 signal msxpi_en_s: std_logic;
	 signal d_s: std_logic_vector(7 downto 0);
begin

   GPIO_21 <= a(14);
	WAIT_n <= 'Z';
	BDIR <= 'Z';

	D <= d_s when SLTSL = '0' and RD_n = '0' else (others => 'Z');
	
	
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



