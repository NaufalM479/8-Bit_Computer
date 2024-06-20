library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity computer_tb is
end computer_tb;

architecture Behavioral of computer_tb is
    -- Component declaration for the DUT (Design Under Test)
    component computer is
        port (
            clock, reset: in std_logic;
            port_in_00: in std_logic_vector(7 downto 0);
            port_in_01: in std_logic_vector(7 downto 0);
            port_in_02: in std_logic_vector(7 downto 0);
            port_in_03: in std_logic_vector(7 downto 0);
            port_in_04: in std_logic_vector(7 downto 0);
            port_in_05: in std_logic_vector(7 downto 0);
            port_in_06: in std_logic_vector(7 downto 0);
            port_in_07: in std_logic_vector(7 downto 0);
            port_in_08: in std_logic_vector(7 downto 0);
            port_in_09: in std_logic_vector(7 downto 0);
            port_in_10: in std_logic_vector(7 downto 0);
            port_in_11: in std_logic_vector(7 downto 0);
            port_in_12: in std_logic_vector(7 downto 0);
            port_in_13: in std_logic_vector(7 downto 0);
            port_in_14: in std_logic_vector(7 downto 0);
            port_in_15: in std_logic_vector(7 downto 0);
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
    end component computer;

    -- Testbench signals
    signal clock_tb, reset_tb: std_logic;
    signal port_in_00_tb, port_in_01_tb, port_in_02_tb, port_in_03_tb: std_logic_vector(7 downto 0);
    signal port_in_04_tb, port_in_05_tb, port_in_06_tb, port_in_07_tb: std_logic_vector(7 downto 0);
    signal port_in_08_tb, port_in_09_tb, port_in_10_tb, port_in_11_tb: std_logic_vector(7 downto 0);
    signal port_in_12_tb, port_in_13_tb, port_in_14_tb, port_in_15_tb: std_logic_vector(7 downto 0);
    signal port_out_00_tb, port_out_01_tb, port_out_02_tb, port_out_03_tb: std_logic_vector(7 downto 0);
    signal port_out_04_tb, port_out_05_tb, port_out_06_tb, port_out_07_tb: std_logic_vector(7 downto 0);
    signal port_out_08_tb, port_out_09_tb, port_out_10_tb, port_out_11_tb: std_logic_vector(7 downto 0);
    signal port_out_12_tb, port_out_13_tb, port_out_14_tb, port_out_15_tb: std_logic_vector(7 downto 0);

begin

    -- Instantiate the DUT
    uut: computer
        port map (
            clock => clock_tb,
            reset => reset_tb,
            port_in_00 => port_in_00_tb,
            port_in_01 => port_in_01_tb,
            port_in_02 => port_in_02_tb,
            port_in_03 => port_in_03_tb,
            port_in_04 => port_in_04_tb,
            port_in_05 => port_in_05_tb,
            port_in_06 => port_in_06_tb,
            port_in_07 => port_in_07_tb,
            port_in_08 => port_in_08_tb,
            port_in_09 => port_in_09_tb,
            port_in_10 => port_in_10_tb,
            port_in_11 => port_in_11_tb,
            port_in_12 => port_in_12_tb,
            port_in_13 => port_in_13_tb,
            port_in_14 => port_in_14_tb,
            port_in_15 => port_in_15_tb,
            port_out_00 => port_out_00_tb,
            port_out_01 => port_out_01_tb,
            port_out_02 => port_out_02_tb,
            port_out_03 => port_out_03_tb,
            port_out_04 => port_out_04_tb,
            port_out_05 => port_out_05_tb,
            port_out_06 => port_out_06_tb,
            port_out_07 => port_out_07_tb,
            port_out_08 => port_out_08_tb,
            port_out_09 => port_out_09_tb,
            port_out_10 => port_out_10_tb,
            port_out_11 => port_out_11_tb,
            port_out_12 => port_out_12_tb,
            port_out_13 => port_out_13_tb,
            port_out_14 => port_out_14_tb,
            port_out_15 => port_out_15_tb
        );

    STIMULUS_PROCESS: process
begin
    clock_tb <= '0';
    reset_tb <= '0';

    -- Wait for initial signals to stabilize
    wait for 10 ns;

    -- Apply reset
    reset_tb <= '1';
    wait for 5 ns;
    reset_tb <= '0';

    -- Generate clock and provide stimulus values
    for i in 0 to 31 loop
        -- Generate clock cycle
        clock_tb <= '0';
        wait for 10 ns;
        clock_tb <= '1';
        wait for 10 ns;

        -- Provide stimulus values
        case i is
            when 0 =>
                port_in_00_tb <= x"00";
            when 1 =>
                port_in_01_tb <= x"11";
            when 2 =>
                port_in_02_tb <= x"22";
            when 3 =>
                port_in_03_tb <= x"33";
            when 4 =>
                port_in_04_tb <= x"44";
            when 5 =>
                port_in_05_tb <= x"55";
            when 6 =>
                port_in_06_tb <= x"66";
            when 7 =>
                port_in_07_tb <= x"77";
            when 8 =>
                port_in_08_tb <= x"88";
            when 9 =>
                port_in_09_tb <= x"99";
            when 10 =>
                port_in_10_tb <= x"AA";
            when 11 =>
                port_in_11_tb <= x"BB";
            when 12 =>
                port_in_12_tb <= x"CC";
            when 13 =>
                port_in_13_tb <= x"DD";
            when 14 =>
                port_in_14_tb <= x"EE";
            when 15 =>
                port_in_15_tb <= x"FF";
            when 16 =>
                port_in_00_tb <= x"FF";
            when 17 =>
                port_in_01_tb <= x"EE";
            when 18 =>
                port_in_02_tb <= x"DD";
            when 19 =>
                port_in_03_tb <= x"CC";
            when 20 =>
                port_in_04_tb <= x"BB";
            when 21 =>
                port_in_05_tb <= x"AA";
            when 22 =>
                port_in_06_tb <= x"99";
            when 23 =>
                port_in_07_tb <= x"88";
            when 24 =>
                port_in_08_tb <= x"77";
            when 25 =>
                port_in_09_tb <= x"66";
            when 26 =>
                port_in_10_tb <= x"55";
            when 27 =>
                port_in_11_tb <= x"44";
            when 28 =>
                port_in_12_tb <= x"33";
            when 29 =>
                port_in_13_tb <= x"22";
            when 30 =>
                port_in_14_tb <= x"11";
            when 31 =>
                port_in_15_tb <= x"00";
        end case;
    end loop;

    -- Wait for simulation to finish
    wait;
end process;



end Behavioral;
