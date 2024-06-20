library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Output_Ports is
port (
			address: in std_logic_vector(3 downto 0);
			data_in: in std_logic_vector(7 downto 0);
			write_en: in std_logic;
			clock: in std_logic;
			reset: in std_logic;
			port_out_00: out std_logic_vector(7 downto 0); 
         port_out_01: out std_logic_vector(7 downto 0);
         port_out_02: out std_logic_vector(7 downto 0);   
         port_out_03: out std_logic_vector(7 downto 0); 
         port_out_04: out std_logic_vector(7 downto 0);  
         port_out_05: out std_logic_vector(7 downto 0);  
         port_out_06: out std_logic_vector(7 downto 0); 
         port_out_07: out std_logic_vector(7 downto 0); 
         port_out_08: out std_logic_vector(7 downto 0); 
         port_out_09: out std_logic_vector(7 downto 0);
         port_out_10: out std_logic_vector(7 downto 0);  
         port_out_11: out std_logic_vector(7 downto 0); 
         port_out_12: out std_logic_vector(7 downto 0); 
         port_out_13: out std_logic_vector(7 downto 0);  
         port_out_14: out std_logic_vector(7 downto 0);   
         port_out_15: out std_logic_vector(7 downto 0)
		);
end Output_Ports;

architecture Behavioral of Output_Ports is
type data_mem is array (0 to 15 ) of std_logic_vector (7 downto 0);
signal RAM: data_mem :=(
							x"00",x"00",x"00",x"00",-- 0x00: (empty location)
							x"00",x"00",x"00",x"00",-- 0x04: (empty location)
							x"00",x"00",x"00",x"00",-- 0x08: (empty location)
							x"00",x"00",x"00",x"00" -- 0x0C: (empty location)
							);	
begin

process(clock,reset)
begin
	if(reset='0') then
		RAM(0) <= x"00";
		RAM(1) <= x"00";
		RAM(2) <= x"00";
		RAM(3) <= x"00";
		RAM(4) <= x"00";
		RAM(5) <= x"00";
		RAM(6) <= x"00";
		RAM(7) <= x"00";
		RAM(8) <= x"00";
		RAM(9) <= x"00";
		RAM(10) <= x"00";
		RAM(11) <= x"00";
		RAM(12) <= x"00";
		RAM(13) <= x"00";
		RAM(14) <= x"00";
		RAM(15) <= x"00";
	elsif(rising_edge(clock)) then
		if(write_en='1') then
			RAM(to_integer(unsigned(address))) <= data_in;
		end if;
	end if;
end process;
			port_out_00 <= RAM(0);
         port_out_01 <= RAM(1);
         port_out_02 <= RAM(2);
         port_out_03 <= RAM(3);
         port_out_04 <= RAM(4);  
         port_out_05 <= RAM(5);
         port_out_06 <= RAM(6); 
         port_out_07 <= RAM(7);
         port_out_08 <= RAM(8);
         port_out_09 <= RAM(9);
         port_out_10 <= RAM(10);
         port_out_11 <= RAM(11);
         port_out_12 <= RAM(12);
         port_out_13 <= RAM(13);
         port_out_14 <= RAM(14);
         port_out_15 <= RAM(15);
		 
		 -- port_out_00 description : ADDRESS x"E0"
PORTOUT_0: process (clock, reset, write_en)
begin
  if (reset = '1') then
     port_out_00 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"E0" and write_en = '1') then
        port_out_00 <= data_in;
     end if;
   end if;
end process;

-- port_out_01 description : ADDRESS x"E1"
PORTOUT_1: process (clock, reset, write_en)
begin
   if (reset = '1') then
      port_out_01 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"E1" and write_en = '1') then
        port_out_01 <= data_in;
     end if;
   end if;
end process;

-- port_out_02 description : ADDRESS x"E2"
PORTOUT_2: process (clock, reset, write_en)
begin
  if (reset = '1') then
     port_out_02 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"E2" and write_en = '1') then
        port_out_02 <= data_in;
     end if;
   end if;
end process;

-- port_out_03 description : ADDRESS x"E3"
PORTOUT_3: process (clock, reset, write_en)
begin
  if (reset = '1') then
     port_out_03 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"E3" and write_en = '1') then
        port_out_03 <= data_in;
     end if;
   end if;
end process;

-- port_out_04 description : ADDRESS x"E4"
PORTOUT_4: process (clock, reset, write_en)
begin
  if (reset = '1') then
     port_out_04 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"E4" and write_en = '1') then
        port_out_04 <= data_in;
     end if;
   end if;
end process;

-- port_out_05 description : ADDRESS x"E5"
PORTOUT_5: process (clock, reset, write_en)
begin
  if (reset = '1') then
     port_out_05 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"E5" and write_en = '1') then
        port_out_05 <= data_in;
     end if;
   end if;
end process;

-- port_out_06 description : ADDRESS x"E6"
PORTOUT_6: process (clock, reset, write_en)
begin
  if (reset = '1') then
     port_out_06 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"E6" and write_en = '1') then
        port_out_06 <= data_in;
     end if;
   end if;
end process;

-- port_out_07 description : ADDRESS x"E7"
PORTOUT_7: process (clock, reset, write_en)
begin
  if (reset = '1') then
     port_out_07 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"E7" and write_en = '1') then
        port_out_07 <= data_in;
     end if;
   end if;
end process;

-- port_out_08 description : ADDRESS x"E8"
PORTOUT_8: process (clock, reset, write_en)
begin
  if (reset = '1') then
     port_out_08 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"E8" and write_en = '1') then
        port_out_08 <= data_in;
     end if;
   end if;
end process;

-- port_out_09 description : ADDRESS x"E9"
PORTOUT_9: process (clock, reset, write_en)
begin
  if (reset = '1') then
     port_out_09 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"E9" and write_en = '1') then
        port_out_09 <= data_in;
     end if;
   end if;
end process;

-- port_out_10 description : ADDRESS x"EA"
PORTOUT_10: process (clock, reset, write_en)
begin
  if (reset = '1') then
     port_out_10 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"EA" and write_en = '1') then
        port_out_10 <= data_in;
     end if;
   end if;
end process;

-- port_out_11 description : ADDRESS x"EB"
PORTOUT_11: process (clock, reset, write_en)
begin
  if (reset = '1') then
     port_out_11 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"EB" and write_en = '1') then
        port_out_11 <= data_in;
     end if;
   end if;
end process;

-- port_out_12 description : ADDRESS x"EC"
PORTOUT_12: process (clock, reset, write_en)
begin
  if (reset = '1') then
     port_out_12 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"EC" and write_en = '1') then
        port_out_12 <= data_in;
     end if;
   end if;
end process;

-- port_out_13 description : ADDRESS x"ED"
PORTOUT_13: process (clock, reset, write_en)
begin
  if (reset = '1') then
     port_out_13 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"ED" and write_en = '1') then
        port_out_13 <= data_in;
     end if;
   end if;
end process;

-- port_out_14 description : ADDRESS x"EE"
PORTOUT_14: process (clock, reset, write_en)
begin
  if (reset = '1') then
     port_out_14 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"EE" and write_en = '1') then
        port_out_14 <= data_in;
     end if;
   end if;
end process;

-- port_out_15 description : ADDRESS x"EF"
PORTOUT_15: process (clock, reset, write_en)
begin
  if (reset = '1') then
     port_out_15 <= x"00";
   elsif (rising_edge(clock)) then
     if (address = x"EF" and write_en = '1') then
        port_out_15 <= data_in;
     end if;
   end if;
end process;
end Behavioral;

