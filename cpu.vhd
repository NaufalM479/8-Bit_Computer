-- LIBRARY INCLUDE FOR CPU
library IEEE;  
use IEEE.STD_LOGIC_1164.ALL;  

 -- CPU component definition
 entity cpu is  
 port(  
                clock, reset: in std_logic;  -- clock and reset
                address: out std_logic_vector(7 downto 0);  -- 8bit address output
                from_memory: in std_logic_vector(7 downto 0); -- data being read from memory 
                write_en: out std_logic; -- data write indicator
                to_memory: out std_logic_vector(7 downto 0) -- data being written to memory 
           );  
 end cpu;  

 architecture Behavioral of cpu is    
 -- component declaration for control unit
 component control_unit   
 port (  
                clock,reset: in std_logic; -- clock and reset  
                IR_Load: out std_logic;  -- load instruction register
                IR: in std_logic_vector(7 downto 0); -- instruction register  
                MAR_Load: out std_logic; -- load memory address register 
                PC_Load: out std_logic; -- load program counter
                PC_Inc: out std_logic; -- increment program counter
                A_Load: out std_logic; -- load register A
                B_Load:out std_logic;  -- load register B
                ALU_Sel:out std_logic_vector(2 downto 0); -- ALU selector
                CCR_Result: in std_logic_vector(3 downto 0); -- Condition Code Register 
                CCR_Load: out std_logic; -- load Condition Code Register
                Bus2_Sel: out std_logic_vector(1 downto 0); -- bus 2 select
                Bus1_Sel: out std_logic_vector(1 downto 0); -- bus 1 select
                write_en: out std_logic -- write indicator
           );  
 end component control_unit;  

 -- components for data path
 component data_path   
 port (            
                clock,reset: in std_logic;  -- clock and reset
                IR_Load: in std_logic;  -- load instruction register
                IR: out std_logic_vector(7 downto 0); -- instruction register  
                MAR_Load: in std_logic; -- load memory address register
                address: out std_logic_vector(7 downto 0);  -- address output
                PC_Load: in std_logic;  -- load program counter
                PC_Inc: in std_logic;  -- increment program counter
                A_Load: in std_logic;  -- load register A
                B_Load: in std_logic;  -- load register B
                ALU_Sel: in std_logic_vector(2 downto 0); -- ALU selector 
                CCR_Result: out std_logic_vector(3 downto 0); -- Condition Code Register
                CCR_Load: in std_logic; -- load Condition Code Register
                Bus2_Sel: in std_logic_vector(1 downto 0); -- bus 2 select
                Bus1_Sel: in std_logic_vector(1 downto 0); -- bus 1 select
                from_memory: in std_logic_vector(7 downto 0);  -- data being read from memory
                to_memory: out std_logic_vector(7 downto 0) -- data being written to memory
           );  
 end component data_path; 

 -- internal process signal, for control unit and data path
 signal               IR_Load: std_logic;  
 signal               IR: std_logic_vector(7 downto 0);  
 signal               MAR_Load: std_logic;  
 signal               PC_Load: std_logic;  
 signal               PC_Inc: std_logic;  
 signal               A_Load: std_logic;  
 signal               B_Load: std_logic;  
 signal               ALU_Sel: std_logic_vector(2 downto 0);  
 signal               CCR_Result: std_logic_vector(3 downto 0);  
 signal               CCR_Load: std_logic;  
 signal               Bus2_Sel: std_logic_vector(1 downto 0);  
 signal               Bus1_Sel: std_logic_vector(1 downto 0);  
 
 begin
 -- port map instantiate control unit module and data path
 -- connecting both to enable data transfer
 
 -- Control Unit Module port map
 control_unit_module: control_unit port map  
 (  
                clock => clock,  
                reset => reset,  
                IR_Load => IR_Load,  
                IR => IR,  
                MAR_Load => MAR_Load,  
                PC_Load => PC_Load,  
                PC_Inc => PC_Inc,  
                A_Load => A_Load,  
                B_Load => B_Load,  
                ALU_Sel => ALU_Sel,  
                CCR_Result => CCR_Result,  
                CCR_Load => CCR_Load,  
                Bus2_Sel => Bus2_Sel,  
                Bus1_Sel => Bus1_Sel,  
                write_en => write_en  
 );  
 
 -- data path port map
 data_path_u: data_path port map   
 (  
                clock => clock,  
                reset => reset,  
                IR_Load => IR_Load,   
                IR => IR,  
                MAR_Load => MAR_Load,  
                address => address,  
                PC_Load => PC_Load,  
                PC_Inc => PC_Inc,  
                A_Load => A_Load,  
                B_Load => B_Load,  
                ALU_Sel => ALU_Sel,  
                CCR_Result => CCR_Result,  
                CCR_Load => CCR_Load,  
                Bus2_Sel => Bus2_Sel,  
                Bus1_Sel => Bus1_Sel,  
                from_memory => from_memory,  
                to_memory => to_memory  
 );  
 end Behavioral;  