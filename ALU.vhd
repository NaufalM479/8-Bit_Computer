-- LIBRARY INCLUDE FOR RAM ALU
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    port (
        A, B: in std_logic_vector(7 downto 0); -- Integer Operand A and B
        ALU_Sel: in std_logic_vector(2 downto 0); -- ALU selector
        NZVC: out std_logic_vector(3 downto 0); -- (N)egative, (Z)ero, o(V)erflow, and (C)arry Flags
        Result: out std_logic_vector(7 downto 0) -- Integer Result
    );
end ALU;

architecture Behavioral of ALU is
    -- internal process signal
    signal ALU_Result: std_logic_vector(7 downto 0);
    signal ALU_ADD: unsigned(8 downto 0);
    signal C, Z, V, N, add_ov, sub_ov: std_logic; 
begin
    process(ALU_Sel, A, B)
    begin
        ALU_ADD <= (others => '0'); --Assign signals to ALU
        -- the code below shows different operation when different Input was given to ALU selector
        case ALU_Sel is
            when "000" => -- ADD
                ALU_ADD <= unsigned('0' & A) + unsigned('0' & B);
                ALU_Result <= std_logic_vector(unsigned(A) + unsigned(B));
            when "001" => -- SUB
                ALU_Result <= std_logic_vector(unsigned(B) - unsigned(A));
                ALU_ADD <= unsigned('0' & B) - unsigned('0' & A);
            when "010" => -- AND
                ALU_Result <= A and B;
            when "011" => -- OR
                ALU_Result <= A or B;
            when "100" => -- Increment
                ALU_Result <= std_logic_vector(unsigned(A) + 1);
            when "101" => -- Decrement
                ALU_Result <= std_logic_vector(unsigned(A) - 1);
            when others => -- if given other value unless stated above
                ALU_Result <= std_logic_vector(unsigned(A) + unsigned(B));
        end case;
    end process;
    
    Result <= ALU_Result;
    
    -- Below was ALU NZVC flags, Condition Code Register (CCR) that controls the ALU
    
    -- Negative (N)
    N <= ALU_Result(7);
    
    -- Zero
    Z <= '1' when ALU_Result = x"00" else '0';

    -- Overflow calculation for addition
    add_ov <= (A(7) and B(7) and (not ALU_Result(7))) or ((not A(7)) and (not B(7)) and ALU_Result(7));
    -- Overflow calculation for addition
    sub_ov <= (A(7) and (not B(7)) and (not ALU_Result(7))) or ((not A(7)) and B(7) and ALU_Result(7));

    -- Overflow flag
    process (ALU_Sel)
    begin
        case ALU_Sel is
            when "000" =>
                V <= add_ov; -- put the add overflow
            when "001" =>
                V <= sub_ov; -- put the sub overflow
            when others =>
                V <= '0';    -- otherwise put 0
        end case;
    end process;

    -- Carry out flag
    process (ALU_Sel)
    begin
        case ALU_Sel is
            when "000" | "001" =>
                C <= ALU_ADD(8);
            when others =>
                C <= '0';
        end case;
    end process;

    NZVC <= N & Z & V & C; -- AND all the flags to NZVC
end Behavioral;
