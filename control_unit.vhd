-- LIBRARY INCLUDE FOR C.U.M (Control Unit Module)
library IEEE;  
use IEEE.STD_LOGIC_1164.ALL;  

-- control unit definition
entity control_unit is  
port ( 
               clock,reset: in std_logic; -- clock and reset signal
               IR_Load: out std_logic; -- load instruction register
               IR: in std_logic_vector(7 downto 0); -- instruction register
               MAR_Load: out std_logic; -- load memory address register
               PC_Load: out std_logic; -- load program counter
               PC_Inc: out std_logic;  -- increment program counter
               A_Load: out std_logic; -- load register A
               B_Load:out std_logic;  -- load register B
               ALU_Sel:out std_logic_vector(2 downto 0); -- ALU selector  
               CCR_Result: in std_logic_vector(3 downto 0); -- Condition Code Register result
               CCR_Load: out std_logic; -- load CCR
               Bus2_Sel: out std_logic_vector(1 downto 0); -- select bus 2 input  
               Bus1_Sel: out std_logic_vector(1 downto 0); -- select bus 1 input
               write_en: out std_logic  -- write indicator
           );  
end control_unit;  

-- FSM enumeration for each 12 states
architecture Behavioral of control_unit is
type FSM is (S_FETCH_0,             -- load Program Counter into Memory Address Register
             S_FETCH_1,             -- increment Program Counter
             S_FETCH_2,             -- load Instruction Register with instruction from memory 
             S_DECODE_3,            -- decode instruction and determine the next state
             S_LOAD_AND_STORE_4,    -- load and store 1st stage
             S_LOAD_AND_STORE_5,    -- load and store 2nd stage
             S_LOAD_AND_STORE_6,    -- load and store 3rd stage
             S_LOAD_AND_STORE_7,    -- load and store 4th stage
             S_DATA_MAN_4,          -- data manipulation
             S_BRANCH_4,            -- branch 1st stage
             S_BRANCH_5,            -- branch 2nd stage
             S_BRANCH_6);           -- branch 3rd stage
 
-- internal process signal
signal current_state,next_state: FSM;  
signal LOAD_STORE_OP,DATA_MAN_OP,BRANCH_OP: std_logic;  
begin  
      -- FSM State Flip-Flops (FF), 
      -- the program below do the synchronous process to update state of Finite State Machine
      -- every rising edge clock it detects
      process(clock,reset)  
      begin  
           if(reset='0') then  
                current_state <= S_FETCH_0; -- set the current state signal to S_FETCH_0
           elsif(rising_edge(clock)) then  
                current_state <= next_state; -- update current state signal to the next state signal
           end if;  
      end process; 

      -- process below updates 
      process(current_state,IR,CCR_Result,LOAD_STORE_OP,DATA_MAN_OP,BRANCH_OP)  
      begin  
                next_state <= current state; -- was done to avoid latches

                -- initialize the signal
                IR_Load <= '0';  
                MAR_Load <= '0';  
                PC_Load <= '0';  
                PC_Inc <= '0';  
                A_Load <= '0';  
                B_Load <= '0';  
                ALU_Sel <= "000";  
                CCR_Load <= '0';  
                Bus2_Sel <= "00";  
                Bus1_Sel <= "00";  
                write_en <= '0';  
                
                -- determine output signals based on current state
                case(current_state) is  
                when S_FETCH_0 =>      -- load PC into MAR
                     Bus1_Sel <= "00";   
                     Bus2_Sel <= "01";   
                     MAR_Load <= '1';  
                     next_state <= S_FETCH_1;  
                when S_FETCH_1 =>      -- increment PC
                     PC_Inc <= '1';  
                     next_state <= S_FETCH_2;  
                when S_FETCH_2 =>      -- load IR with instruction from memory
                     Bus2_Sel <= "10";  
                     IR_Load <= '1';  
                     next_state <= S_DECODE_3;  
                when S_DECODE_3 =>     -- decode instruction and determine what's the next tate
                     if(LOAD_STORE_OP='1') then             -- if load/store 
                          next_state <= S_LOAD_AND_STORE_4;    -- go to state 4 load and store
                     elsif(DATA_MAN_OP='1') then            -- if data manipulation
                          next_state <= S_DATA_MAN_4;          -- go to state 4 data manipulation
                     elsif(BRANCH_OP='1') then              -- if branch
                          next_state <= S_BRANCH_4;            -- go to state 4 branch
                     end if;  

                ---- LOAD AND STORE INSTRUCTIONS:  
                when S_LOAD_AND_STORE_4 =>  
                     if(IR >= x"86" and IR <= x"89")then -- LOAD IMMEDIATE  
                          Bus1_Sel <= "00";  
                          Bus2_Sel <= "01";  
                          MAR_Load <= '1';            
                     elsif(IR = x"96" or IR = x"97")then -- LOAD IMMEDIATE  
                          Bus1_Sel <= "00";  
                          Bus2_Sel <= "01";  
                          MAR_Load <= '1';                                
                     end if;  
                     next_state <= S_LOAD_AND_STORE_5;  
                when S_LOAD_AND_STORE_5 =>  
                     if(IR >= x"86" and IR <= x"89")then -- LOAD IMMEDIATE  
                          PC_Inc <= '1';  
                     elsif(IR = x"96" or IR = x"97")then  
                          PC_Inc <= '1';  
                     end if;  
                     next_state <= S_LOAD_AND_STORE_6;  
                when S_LOAD_AND_STORE_6 =>  
                     if(IR=x"86")then -- LOAD IMMEDIATE A  
                          Bus2_Sel <= "10";  
                          A_Load <= '1';  
                          next_state <= S_FETCH_0;  
                     elsif(IR=x"87" or IR=x"89") then -- LOAD A DIRECT  
                          Bus2_Sel <= "10";  
                          MAR_Load <= '1';            
                          next_state <= S_LOAD_AND_STORE_7;  
                     elsif(IR=x"88")then -- LOAD IMMEDIATE B  
                          Bus2_Sel <= "10";  
                          B_Load <= '1';  
                          next_state <= S_FETCH_0;       
                     elsif(IR = x"96" or IR = x"97")then  
                          Bus2_Sel <= "10";  
                          MAR_Load <= '1';            
                          next_state <= S_LOAD_AND_STORE_7;                           
                     end if;  
                when S_LOAD_AND_STORE_7 =>  
                          if(IR=x"87") then  
                               Bus2_Sel <= "10";  
                               A_Load <= '1';            
                               next_state <= S_FETCH_0;  
                          elsif(IR=x"89") then  
                               Bus2_Sel <= "10";  
                               B_Load <= '1';            
                               next_state <= S_FETCH_0;       
                          elsif(IR=x"96") then  
                               write_en <= '1';  
                               Bus1_Sel <= "01";  
                               next_state <= S_FETCH_0;  
                          elsif(IR=x"97") then  
                               write_en <= '1';  
                               Bus1_Sel <= "10";  
                               next_state <= S_FETCH_0;  
                          end if;  

                ---- DATA MANIPULATION INSTRUCTIONS: 
                ---  filled with AND OR NOT etc. 
                when S_DATA_MAN_4 =>   
                     CCR_Load <= '1';  
                     if(IR=x"42") then      
                          ALU_Sel <= "000"; -- ADD
                          Bus1_Sel <= "01";  
                          Bus2_Sel <= "00";  
                          A_Load <= '1';  
                     elsif(IR=x"43") then   
                          ALU_Sel <= "001"; -- SUB 
                          Bus1_Sel <= "01";  
                          Bus2_Sel <= "00";  
                          A_Load <= '1';  
                     elsif(IR=x"44") then  
                          ALU_Sel <= "010"; -- AND 
                          Bus1_Sel <= "01";  
                          Bus2_Sel <= "00";  
                          A_Load <= '1';            
                     elsif(IR=x"45") then  
                          ALU_Sel <= "011"; -- OR 
                          Bus1_Sel <= "01";  
                          Bus2_Sel <= "00";  
                          A_Load <= '1';            
                     elsif(IR=x"46") then  
                          ALU_Sel <= "100"; -- INCREMENT
                          Bus1_Sel <= "01";  
                          Bus2_Sel <= "00";  
                          A_Load <= '1';                      
                     elsif(IR=x"47") then  
                          ALU_Sel <= "100"; -- INCREMENT 
                          Bus1_Sel <= "10";  
                          Bus2_Sel <= "00";  
                          B_Load <= '1';                 
                     elsif(IR=x"48") then  
                          ALU_Sel <= "101"; -- DECREMENT
                          Bus1_Sel <= "01";  
                          Bus2_Sel <= "00";  
                          A_Load <= '1';       
                     elsif(IR=x"49") then  
                          ALU_Sel <= "101"; -- DECREMENT
                          Bus1_Sel <= "10";  
                          Bus2_Sel <= "00";  
                          B_Load <= '1';                                
                     end if;  
                     next_state <= S_FETCH_0;  
                when S_BRANCH_4 =>  
                     if(IR >= x"20" and IR <= x"28")then -- BRA  
                          Bus1_Sel <= "00";  
                          Bus2_Sel <= "01";  
                          MAR_Load <= '1';                                
                     end if;  
                     next_state <= S_BRANCH_5;  
                when S_BRANCH_5 =>  
                     if(IR >= x"20" and IR <= x"28")then -- BRA  
                          PC_Inc <= '1';  
                     end if;  
                     next_state <= S_BRANCH_6;  
                when S_BRANCH_6 =>  
                     if(IR=x"20")then -- BRA  
                          Bus2_Sel <= "10";  
                          PC_Load <= '1';       
                     elsif(IR=x"21")then -- BMI  
                          Bus2_Sel <= "10";  
                          if(CCR_Result(3)='1') then  
                               PC_Load <= '1';  
                          end if;  
                     elsif(IR=x"22")then -- BPL  
                          Bus2_Sel <= "10";  
                          if(CCR_Result(3)='0') then  
                               PC_Load <= '1';  
                          end if;  
                     elsif(IR=x"23")then -- BEQ  
                          Bus2_Sel <= "10";  
                          if(CCR_Result(2)='1') then-- Z = '1'?  
                               PC_Load <= '1';  
                          end if;  
                     elsif(IR=x"24")then -- BNE  
                          Bus2_Sel <= "10";  
                          if(CCR_Result(2)='0') then-- Z = '0'?  
                               PC_Load <= '1';  
                          end if;  
                     elsif(IR=x"25")then -- BVS  
                          Bus2_Sel <= "10";  
                          if(CCR_Result(1)='1') then-- V = '1'?  
                               PC_Load <= '1';  
                          end if;  
                     elsif(IR=x"26")then -- BVC  
                          Bus2_Sel <= "10";  
                          if(CCR_Result(1)='0') then-- V = '0'?  
                               PC_Load <= '1';  
                          end if;  
                     elsif(IR=x"27")then -- BCS  
                          Bus2_Sel <= "10";  
                          if(CCR_Result(0)='1') then-- C = '1'?  
                               PC_Load <= '1';  
                          end if;  
                     elsif(IR=x"28")then -- BCC  
                          Bus2_Sel <= "10";  
                          if(CCR_Result(0)='0') then-- C = '0'?  
                               PC_Load <= '1';  
                          end if;  
                     end if;  
                     next_state <= S_FETCH_0;  -- back to state 0
                when others =>  
                     next_state <= S_FETCH_0;  -- back to state 0
           end case;  
      end process;  
     
      -- signal assignment, manage the next state to decode
      LOAD_STORE_OP <= '1' when IR = x"86" else  
                                '1' when IR = x"87" else  
                                '1' when IR = x"88" else  
                                '1' when IR = x"89" else  
                                '1' when IR = x"96" else  
                                '1' when IR = x"97" else            
                                '0';
                                
      -- Assign the LOAD_STORE_OP signal based on the current instruction in the IR
      DATA_MAN_OP <=  '1' when (IR >= x"42" and IR <=x"49") else       
                                '0';  
      -- Assign the DATA_MAN_OP signal based on the current instruction in the IR
      BRANCH_OP  <=  '1' when (IR >= x"20" and IR <= x"28") else       
                                '0';  
 end Behavioral;  
