
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rw_96x8_sync is
port(
			address: in std_logic_vector(6 downto 0);
			data_in: in std_logic_vector(7 downto 0);
			write_en: in std_logic;
			clock: in std_logic;
			data_out: out std_logic_vector(7 downto 0)
		);
end rw_96x8_sync;

architecture Behavioral of rw_96x8_sync is
type data_mem is array (0 to 95 ) of std_logic_vector (7 downto 0);
signal RAM: data_mem :=(
							x"33",x"22",x"00",x"00",-- 0x00: (empty location)
							x"00",x"00",x"00",x"00",-- 0x04: (empty location)
							x"00",x"00",x"00",x"00",-- 0x08: (empty location)
							x"00",x"00",x"00",x"00",-- 0x0C: (empty location)
							x"00",x"00",x"00",x"00",-- 0x10: (empty location)
							x"00",x"00",x"00",x"00",-- 0x14: (empty location)
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
							x"00",x"00",x"00",x"00"-- 0x5C: (empty location)
							);	

							type rw_type is array (128 to 223) of std_logic_vector(7 downto 0);

							signal RW : rw_type;
							signal EN: std_logic;
							begin
process(clock)
begin
	nable : process (address)
	begin
		if ( (to_integer(unsigned(address)) >= 128) and
		(to_integer(unsigned(address)) <= 223)) then
			EN <= '1';
		else
			EN <= '0';
		end if;
	end process;

	memory : process (clock,EN,write_en)
	begin
		if (rising_edge(clock)) then
		  if (EN='1' and write_en='1') then
			RW(to_integer(unsigned(address))) <= data_in;
		elsif (EN='1' and write_en='0') then
			data_out <= RW(to_integer(unsigned(address)));
		  end if;
	end if;
	end process;
	
	if(rising_edge(clock)) then
		if(write_en='1') then
			RAM(to_integer(unsigned(address))) <= data_in;
		end if;
	end if;
end process;
	data_out <= RAM(to_integer(unsigned(address)));
end Behavioral;

