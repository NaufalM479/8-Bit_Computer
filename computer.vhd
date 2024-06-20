-- LIBRARY INCLUDE FOR COMPUTER
-- Also the top of design
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- I/O port definition, each stores array with 8 members
entity computer is
    port (
        clock, reset: in std_logic;
        port_in_00: in std_logic_vector(7 downto 0);    -- INPUT 1
        port_in_01: in std_logic_vector(7 downto 0);    -- INPUT 2
        port_in_02: in std_logic_vector(7 downto 0);    -- INPUT 3
        port_in_03: in std_logic_vector(7 downto 0);    -- INPUT 4
        port_in_04: in std_logic_vector(7 downto 0);    -- INPUT 5
        port_in_05: in std_logic_vector(7 downto 0);    -- INPUT 6
        port_in_06: in std_logic_vector(7 downto 0);    -- INPUT 7
        port_in_07: in std_logic_vector(7 downto 0);    -- INPUT 8
        port_in_08: in std_logic_vector(7 downto 0);    -- INPUT 9
        port_in_09: in std_logic_vector(7 downto 0);    -- INPUT 10
        port_in_10: in std_logic_vector(7 downto 0);    -- INPUT 11
        port_in_11: in std_logic_vector(7 downto 0);    -- INPUT 12
        port_in_12: in std_logic_vector(7 downto 0);    -- INPUT 13
        port_in_13: in std_logic_vector(7 downto 0);    -- INPUT 14
        port_in_14: in std_logic_vector(7 downto 0);    -- INPUT 15
        port_in_15: in std_logic_vector(7 downto 0);    -- INPUT 16 

        port_out_00: out std_logic_vector(7 downto 0);  -- OUTPUT 1
        port_out_01: out std_logic_vector(7 downto 0);  -- OUTPUT 2
        port_out_02: out std_logic_vector(7 downto 0);  -- OUTPUT 3
        port_out_03: out std_logic_vector(7 downto 0);  -- OUTPUT 4
        port_out_04: out std_logic_vector(7 downto 0);  -- OUTPUT 5
        port_out_05: out std_logic_vector(7 downto 0);  -- OUTPUT 6
        port_out_06: out std_logic_vector(7 downto 0);  -- OUTPUT 7
        port_out_07: out std_logic_vector(7 downto 0);  -- OUTPUT 8
        port_out_08: out std_logic_vector(7 downto 0);  -- OUTPUT 9
        port_out_09: out std_logic_vector(7 downto 0);  -- OUTPUT 10
        port_out_10: out std_logic_vector(7 downto 0);  -- OUTPUT 11
        port_out_11: out std_logic_vector(7 downto 0);  -- OUTPUT 12
        port_out_12: out std_logic_vector(7 downto 0);  -- OUTPUT 13
        port_out_13: out std_logic_vector(7 downto 0);  -- OUTPUT 14
        port_out_14: out std_logic_vector(7 downto 0);  -- OUTPUT 15
        port_out_15: out std_logic_vector(7 downto 0)   -- OUTPUT 16
    );
end computer;

architecture Behavioral of computer is
    -- Computer port definition
    component cpu is
        port (
            clock, reset: in std_logic; -- clock and reset input signal            
            address: out std_logic_vector(7 downto 0); -- 8 bit address
            write_en: out std_logic; -- write indicator, indicates CPU writing if high
            from_memory: in std_logic_vector(7 downto 0); -- data being read from memory
            to_memory: out std_logic_vector(7 downto 0)   -- data being written to memory
        );
    end component cpu;
    
    -- Memory port definition
    component memory is
        port (
            address: in std_logic_vector(7 downto 0);       -- ADDRESS
            write_en: in std_logic;                         -- Write
            data_in: in std_logic_vector(7 downto 0);       -- Data in
            data_out: out std_logic_vector(7 downto 0);     -- Data out

            port_in_00: in std_logic_vector(7 downto 0);    -- INPUT 1
            port_in_01: in std_logic_vector(7 downto 0);    -- INPUT 2
            port_in_02: in std_logic_vector(7 downto 0);    -- INPUT 3
            port_in_03: in std_logic_vector(7 downto 0);    -- INPUT 4
            port_in_04: in std_logic_vector(7 downto 0);    -- INPUT 5
            port_in_05: in std_logic_vector(7 downto 0);    -- INPUT 6
            port_in_06: in std_logic_vector(7 downto 0);    -- INPUT 7
            port_in_07: in std_logic_vector(7 downto 0);    -- INPUT 8
            port_in_08: in std_logic_vector(7 downto 0);    -- INPUT 9
            port_in_09: in std_logic_vector(7 downto 0);    -- INPUT 10
            port_in_10: in std_logic_vector(7 downto 0);    -- INPUT 11
            port_in_11: in std_logic_vector(7 downto 0);    -- INPUT 12
            port_in_12: in std_logic_vector(7 downto 0);    -- INPUT 13
            port_in_13: in std_logic_vector(7 downto 0);    -- INPUT 14
            port_in_14: in std_logic_vector(7 downto 0);    -- INPUT 15
            port_in_15: in std_logic_vector(7 downto 0);    -- INPUT 16 

            port_out_00: out std_logic_vector(7 downto 0);  -- OUTPUT 1
            port_out_01: out std_logic_vector(7 downto 0);  -- OUTPUT 2
            port_out_02: out std_logic_vector(7 downto 0);  -- OUTPUT 3
            port_out_03: out std_logic_vector(7 downto 0);  -- OUTPUT 4
            port_out_04: out std_logic_vector(7 downto 0);  -- OUTPUT 5
            port_out_05: out std_logic_vector(7 downto 0);  -- OUTPUT 6
            port_out_06: out std_logic_vector(7 downto 0);  -- OUTPUT 7
            port_out_07: out std_logic_vector(7 downto 0);  -- OUTPUT 8
            port_out_08: out std_logic_vector(7 downto 0);  -- OUTPUT 9
            port_out_09: out std_logic_vector(7 downto 0);  -- OUTPUT 10
            port_out_10: out std_logic_vector(7 downto 0);  -- OUTPUT 11
            port_out_11: out std_logic_vector(7 downto 0);  -- OUTPUT 12
            port_out_12: out std_logic_vector(7 downto 0);  -- OUTPUT 13
            port_out_13: out std_logic_vector(7 downto 0);  -- OUTPUT 14
            port_out_14: out std_logic_vector(7 downto 0);  -- OUTPUT 15
            port_out_15: out std_logic_vector(7 downto 0)   -- OUTPUT 16
        );
    end component memory;
    
    -- Internal Process signal
    signal address, data_in, data_out: std_logic_vector(7 downto 0);
    signal write_en: std_logic;

begin
    -- Port Map instantiates CPU and Memory modules,
    -- connecting both to enable data transfer

    -- CPU port map
    cpu_u: cpu port map
    (
        clock => clock,
        reset => reset,
        address => address,
        write_en => write_en,
        to_memory => data_in,
        from_memory => data_out
    );

    -- Memory port map
    memory_unit: memory port map
    (
        clock => clock,
        reset => reset,
        port_out_00 => port_out_00,
        port_out_01 => port_out_01,
        port_out_02 => port_out_02,
        port_out_03 => port_out_03,
        port_out_04 => port_out_04,
        port_out_05 => port_out_05,
        port_out_06 => port_out_06,
        port_out_07 => port_out_07,
        port_out_08 => port_out_08,
        port_out_09 => port_out_09,
        port_out_10 => port_out_10,
        port_out_11 => port_out_11,
        port_out_12 => port_out_12,
        port_out_13 => port_out_13,
        port_out_14 => port_out_14,
        port_out_15 => port_out_15,
        port_in_00 => port_in_00,
        port_in_01 => port_in_01,
        port_in_02 => port_in_02,
        port_in_03 => port_in_03,
        port_in_04 => port_in_04,
        port_in_05 => port_in_05,
        port_in_06 => port_in_06,
        port_in_07 => port_in_07,
        port_in_08 => port_in_08,
        port_in_09 => port_in_09,
        port_in_10 => port_in_10,
        port_in_11 => port_in_11,
        port_in_12 => port_in_12,
        port_in_13 => port_in_13,
        port_in_14 => port_in_14,
        port_in_15 => port_in_15,
        address => address,
        write_en => write_en,
        data_in => data_in,
        data_out => data_out
    );

end Behavioral;
