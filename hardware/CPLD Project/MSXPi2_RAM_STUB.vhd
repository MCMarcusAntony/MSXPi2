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

entity MSXPi2_RAM_STUB is
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

end MSXPi2_RAM_STUB;

architecture ppl_type of MSXPi2_RAM_STUB is

    signal led_s: std_logic;
	 signal access_s: std_logic;
	 signal msxpi_en_s: std_logic;
	 signal d_s: std_logic_vector(7 downto 0);
	 signal d_reg: std_logic_vector(7 downto 0);
begin

   GPIO_21 <= a(14);
	WAIT_n <= 'Z';
	BDIR <= 'Z';

	D <= d_s when SLTSL = '0' and RD_n = '0' else (others => 'Z');
	
	process(SLTSL)
	begin
	   if (SLTSL'event and SLTSL = '0') then
		    if (WR_n = '0') then
			     d_reg <= D;
          elsif (RD_n = '0') then 
			     case A is
				      when x"FFFF" =>
						    d_s <= x"FF";
						when OTHERS =>
							d_s <= d_reg;
				  end case;
			end if;
		end if;
	end process;

end;



