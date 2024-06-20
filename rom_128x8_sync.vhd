
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity rom_128x8_sync is
port (
			address: in std_logic_vector(6 downto 0);
			data_out: out std_logic_vector(7 downto 0);
			clock: in std_logic
		);
end rom_128x8_sync;

architecture Behavioral of rom_128x8_sync is
type instmem is array (0 to 127 ) of std_logic_vector (7 downto 0);
signal ROM: instmem :=( -- test program
							x"86",x"AA",x"87",x"80",-- 0x00: (empty location)
							x"88",x"44",x"89",x"81",-- 0x04: (empty location)
							x"96",x"82",x"97",x"83",-- 0x08: (empty location)
							x"42",x"43",x"44",x"45",-- 0x0C: (empty location)
							x"46",x"47",x"48",x"49",-- 0x10: (empty location)
							x"27",x"00",x"28",x"00",-- 0x14: (empty location)
							x"00",x"00",x"00",x"00",-- 0x18: (empty location)
							x"00",x"00",x"00",x"00",-- 0x1C: (empty location)
							x"00",x"00",x"00",x"00",-- 0x20: (empty location)
							x"00",x"00",x"00",x"00",-- 0x24: (empty location)
							x"00",x"00",x"00",x"00",-- 0x28: (empty location)
							x"00",x"00",x"00",x"00",-- 0x2C: (empty location)
							x"00",x"00",x"00",x"00",-- 0x30: (empty location)
							x"00",x"00",x"00",x"00",-- 0x34: (empty location)
							x"00",x"00",x"00",x"00",-- 0x38: (empty location)
							x"00",x"00",x"00",x"00",-- 0x3C: (empty location)
							x"00",x"00",x"00",x"00",-- 0x40: (empty location)
							x"00",x"00",x"00",x"00",-- 0x44: (empty location)
							x"00",x"00",x"00",x"00",-- 0x48: (empty location)
							x"00",x"00",x"00",x"00",-- 0x4C: (empty location)
							x"00",x"00",x"00",x"00",-- 0x50: (empty location)
							x"00",x"00",x"00",x"00",-- 0x54: (empty location)
							x"00",x"00",x"00",x"00",-- 0x58: (empty location)
							x"00",x"00",x"00",x"00",-- 0x5C: (empty location)
							x"00",x"00",x"00",x"00",-- 0x60: (empty location)
							x"00",x"00",x"00",x"00",-- 0x64: (empty location)
							x"00",x"00",x"00",x"00",-- 0x68: (empty location)
							x"00",x"00",x"00",x"00",-- 0x6C: (empty location)
							x"00",x"00",x"00",x"00",-- 0x70: (empty location)
							x"00",x"00",x"00",x"00",-- 0x74: (empty location)
							x"00",x"00",x"00",x"00",-- 0x78: (empty location)
							x"00",x"00",x"00",x"00" -- 0x7C: (empty location)
							);	

							--  ----- INSTRUCTION SET -----
-- These instructions are sufficient to provide a baseline of functionality.
-- Additional instructions can be added as desired to increase the complexity of the system.
constant LDA_IMM: std_logic_vector (7 downto 0) := x"86";
constant LDA_DIR: std_logic_vector (7 downto 0) := x"87";
constant LDB_IMM: std_logic_vector (7 downto 0) := x"88";
constant LDB_DIR: std_logic_vector (7 downto 0) := x"89";
constant STA_DIR: std_logic_vector (7 downto 0) := x"96";
constant STB_DIR: std_logic_vector (7 downto 0) := x"97";
constant ADD_AB : std_logic_vector (7 downto 0) := x"42";
constant SUB_AB : std_logic_vector (7 downto 0) := x"43";
constant AND_AB : std_logic_vector (7 downto 0) := x"44";
constant OR_AB  : std_logic_vector (7 downto 0) := x"45";
constant INCA   : std_logic_vector (7 downto 0) := x"46";
constant INCB   : std_logic_vector (7 downto 0) := x"47";
constant DECA   : std_logic_vector (7 downto 0) := x"48";
constant DECB   : std_logic_vector (7 downto 0) := x"49";
constant BRA    : std_logic_vector (7 downto 0) := x"20";
constant BMI    : std_logic_vector (7 downto 0) := x"21";
constant BPL    : std_logic_vector (7 downto 0) := x"22";
constant BEQ    : std_logic_vector (7 downto 0) := x"23";
constant BNE    : std_logic_vector (7 downto 0) := x"24";
constant BVS    : std_logic_vector (7 downto 0) := x"25";
constant BVC    : std_logic_vector (7 downto 0) := x"26";
constant BCS    : std_logic_vector (7 downto 0) := x"27";
constant BCC    : std_logic_vector (7 downto 0) := x"28";

type rom_type is array (0 to 127) of std_logic_vector(7 downto 0);
-- The program  perform a load, store, and a branch always.

-- This program will continually write x”AA” to port_out_00:
-- constant ROM : rom_type := (0=> LDA_IMM,
--			    1=> x"AA",
--			    2=> STA_DIR,
--			    3=> x"E0",
--			    4=> BRA,
--			    5=> x"00",
--			    others => x"00");

-- This program will continually write read port_in_00 and put it in regA, 
-- read port_in_01 and put the value in the regB and put the sum in port_out_00
constant ROM : rom_type := (
			    0 => LDA_DIR ,
                1 => x"F0",
                2 => STA_DIR ,
                3 => x"E0",
                4 => BRA,
                5 => x"00",
			    others => x"00");


begin
	ENABLE: process (address)
	begin
		if ((to_integer(unsigned(address)) >= 0) and
		(to_integer(unsigned(address)) <= 127)) then
			EN <= '1';
		else
			EN <= '0';
		end if;
	end process;

	MEMORY: process (clock,EN)
begin
	if (rising_edge(clock)) then
		if (EN='1') then
			data_out <= ROM(to_integer(unsigned(address)));
		end if;
	end if;
end process;


process(clock) 
begin	
	if(rising_edge(clock)) then
		data_out <= ROM(to_integer(unsigned(address)));
	end if;
end process;
end Behavioral;

