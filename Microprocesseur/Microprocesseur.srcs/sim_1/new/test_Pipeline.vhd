----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2024 12:41:33 PM
-- Design Name: 
-- Module Name: test_Pipeline - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_Pipeline is
--  Port ( );
end test_Pipeline;

architecture Behavioral of test_Pipeline is

  -- Component declaration of the entity under test (UUT)
    component Pipeline
        Port (
            clk : in std_logic;
            rst : in std_logic;
            -- Ports pour la mémoire d'instructions
            instr_data : in std_logic_vector(31 downto 0);
            -- Ports pour le banc de registres
            reg_W : out STD_LOGIC;   -- Signal d'écriture
            reg_ADD_A : out STD_LOGIC_VECTOR (3 downto 0); -- Adresse de lecture A
            reg_ADD_B: out STD_LOGIC_VECTOR (3 downto 0);  -- Adresse de lecture B
            reg_ADD_W : out STD_LOGIC_VECTOR (3 downto 0); -- Adresse d'écriture
            reg_DATA : out STD_LOGIC_VECTOR(7 downto 0);   -- Données à écrire
            reg_QA : in STD_LOGIC_VECTOR (7 downto 0);   -- Sortie des données pour A
            reg_QB : in STD_LOGIC_VECTOR (7 downto 0);    -- Sortie des données pour
            --Ports pour l'ALU
            alu_Num1 : out std_logic_vector(7 downto 0);
            alu_Num2 : out std_logic_vector(7 downto 0);
            alu_Res : in std_logic_vector(7 downto 0);
            alu_OP : out std_logic_vector(2 downto 0);
            -- Ports pour la mémoire de données
            data_addr : out std_logic_vector(7 downto 0);
            data_in : out std_logic_vector(7 downto 0);
            data_out : in std_logic_vector(7 downto 0);
            data_rw : out std_logic -- 1 pour lecture, 0 pour écriture
        );
    end component;

    -- Signals to connect to UUT
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal instr_data : std_logic_vector(31 downto 0);
    signal reg_W : std_logic := '0';
    signal reg_ADD_A : std_logic_vector(3 downto 0);
    signal reg_ADD_B : std_logic_vector(3 downto 0);
    signal reg_ADD_W : std_logic_vector(3 downto 0);
    signal reg_DATA : std_logic_vector(7 downto 0);
    signal reg_QA : std_logic_vector(7 downto 0) := (others => '0');
    signal reg_QB : std_logic_vector(7 downto 0) := (others => '0');
    signal alu_Num1 : std_logic_vector(7 downto 0);
    signal alu_Num2 : std_logic_vector(7 downto 0);
    signal alu_Res : std_logic_vector(7 downto 0) := (others => '0');
    signal alu_OP : std_logic_vector(2 downto 0);
    signal data_addr : std_logic_vector(7 downto 0);
    signal data_in : std_logic_vector(7 downto 0);
    signal data_out : std_logic_vector(7 downto 0) := (others => '0');
    signal data_rw : std_logic := '0';
    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Pipeline
        Port map (
            clk => clk,
            rst => rst,
            instr_data => instr_data,
            reg_W => reg_W,
            reg_ADD_A => reg_ADD_A,
            reg_ADD_B => reg_ADD_B,
            reg_ADD_W => reg_ADD_W,
            reg_DATA => reg_DATA,
            reg_QA => reg_QA,
            reg_QB => reg_QB,
            alu_Num1 => alu_Num1,
            alu_Num2 => alu_Num2,
            alu_Res => alu_Res,
            alu_OP => alu_OP,
            data_addr => data_addr,
            data_in => data_in,
            data_out => data_out,
            data_rw => data_rw
        );

    -- Clock process definitions
    CLK_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the system
        rst <= '0';
        wait for CLK_PERIOD/2;
        rst <= '1';

        -- Initialize the inputs
        instr_data <= x"01020001"; -- Example instruction: ADD reg2, reg0, reg1: "00000001 00000010 0000000 00000001"
        
        wait for CLK_PERIOD;
        reg_QA <= "00000011"; -- reg0 = 3
        reg_QB <= "00000101"; -- reg1 = 5
        instr_data <= x"02020001"; -- New instruction arrives: MUL reg2 reg0 reg1 "00000010 00000010 00000000 00000001"
        
        wait for CLK_PERIOD;    
        alu_Res <= "00001000"; -- Expected ALU result = 8 (3 + 5)
        instr_data <= x"05000100"; -- COP reg0 reg1 "00000101 00000000 00000001 00000000"
        
        wait for CLK_PERIOD;
        reg_QA <= "00000011"; -- reg0 = 3
        reg_QB <= "00001010"; -- reg1 = 10
        alu_Res <= "00001111"; -- Expected ALU result for instr2 = 15
        instr_data <= x"06030500"; -- AFC reg3 5 "00000110 00000011 00000101 00000000"
        
        wait for CLK_PERIOD;
        reg_QA <= "00001111";
        
        wait for CLK_PERIOD;
        --Check results
        assert reg_W = '1' report "Test failed: reg_W should be '1'" severity error;
        assert reg_ADD_W = "0010" report "Test failed: reg_ADD_W should be '0010'" severity error;
        assert reg_DATA = "00001000" report "Test failed: reg_DATA should be '00001000'" severity error;

        wait for CLK_PERIOD;
        assert reg_W = '1' report "Test failed: reg_W should be '1'" severity error;
        assert reg_ADD_W = "0010" report "Test failed: reg_ADD_W should be '0010'" severity error;
        assert reg_DATA = "00001111" report "Test failed: reg_DATA should be '00001111'" severity error;
        
        wait for CLK_PERIOD;
        assert reg_W = '1' report "Test failed: reg_W should be '1'" severity error;
        assert reg_ADD_W = "0000" report "Test failed: reg_ADD_W should be '0010'" severity error;
        assert reg_DATA = "00001010" report "Test failed: reg_DATA should be '00001111'" severity error;
        
        wait for CLK_PERIOD;
        assert reg_W = '1' report "Test failed: reg_W should be '1'" severity error;
        assert reg_ADD_W = "0011" report "Test failed: reg_ADD_W should be '0010'" severity error;
        assert reg_DATA = "00000101" report "Test failed: reg_DATA should be '00001111'" severity error;
        

        -- End of test
        report "Testbench completed successfully" severity note;
        wait;
    end process;


end Behavioral;
