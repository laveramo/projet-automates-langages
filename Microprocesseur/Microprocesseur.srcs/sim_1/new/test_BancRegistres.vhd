----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2024 02:59:41 PM
-- Design Name: 
-- Module Name: test_BancRegistres - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_BancRegistres is
end test_BancRegistres;

architecture Behavioral of test_BancRegistres is
component BancRegistres
Port (  CLK : in STD_LOGIC; -- Horloge
        RST : in STD_LOGIC; -- Signal de reset actif à 0
        W : in STD_LOGIC;   -- Signal d'écriture
        ADD_A : in STD_LOGIC_VECTOR (3 downto 0); -- Adresse de lecture A
        ADD_B: in STD_LOGIC_VECTOR (3 downto 0);  -- Adresse de lecture B
        ADD_W : in STD_LOGIC_VECTOR (3 downto 0); -- Adresse d'écriture
        DATA : in STD_LOGIC_VECTOR(7 downto 0);   -- Données à écrire
        QA : out STD_LOGIC_VECTOR (7 downto 0);   -- Sortie des données pour A
        QB : out STD_LOGIC_VECTOR (7 downto 0)    -- Sortie des données pour 
);
end component;

-- Signals pour tester
signal test_ck, test_rst, test_in : std_logic := '0';
signal test_addA, test_addB, test_addW : std_logic_vector(3 downto 0) := (others => '0');
signal test_data : std_logic_vector(7 downto 0) := (others => '0');
signal test_qa, test_qb : std_logic_vector(7 downto 0);

-- Clock
constant CK_period : time := 10 ns;

begin

-- Unit Under Test
test_banc : BancRegistres port map (
    CLK => test_ck,
    RST => test_rst,
    W => test_in,
    ADD_A => test_addA,
    ADD_B => test_addB,
    ADD_W => test_addW,
    DATA => test_data,
    QA => test_qa,
    QB => test_qb
);

-- Clock generation
Clock_process : process
begin
    test_ck <= not(test_ck);
    wait for CK_period/2;
end process;

-- Test du banc de registres
stim_process : process
begin
-- Initialize Inputs
        test_rst <= '0';
        WAIT FOR 20 ns;
        test_rst <= '1';  -- De-assert reset
        
-- Test 1: Multiple Registers
    -- Write to register 0
    test_in <= '1';
    test_addW <= "0000";
    test_data <= X"AA";
    WAIT FOR CK_period;
    -- Write to register 15
    test_addA<= "1111";
    test_data <= X"55";
    WAIT FOR CK_period;
    test_in <= '0';  -- End Writing
    WAIT FOR CK_period;
        
    -- Read from register 0 and 15
    test_addA <= "0000";
    test_addB <= "1111";
    WAIT FOR CK_period;

    ASSERT test_qa = X"AA" AND test_qb = X"55"
    REPORT "Error in Test 1: Multi-register access failed"
    SEVERITY error;
    
 -- Test 2: Boundary Conditions
    -- Reset the system first
    test_rst <= '0';
    WAIT FOR CK_period;
    test_rst <= '1';
    WAIT FOR CK_period;

    test_in <= '1';
    test_addW <= "0000";
    test_data <= X"01";
    WAIT FOR CK_period;
    test_addW <= "1111";
    test_data <= X"FE";
    WAIT FOR CK_period;
    test_in <= '0';
    WAIT FOR CK_period;

    test_addA <= "0000";
    test_addB <= "1111";
    WAIT FOR CK_period;

    ASSERT test_qa = X"01" AND test_qb = X"FE"
    REPORT "Error in Test 2: Boundary condition test failed"
    SEVERITY error;
    
-- Test 3: Simultaneous Read/Write
    -- Reset and setup
    test_rst <= '0';
    WAIT FOR CK_period;
    test_rst <= '1';
    WAIT FOR CK_period;

    test_in <= '1';
    test_addW <= "0010";
    test_data <= X"C3";
    WAIT FOR CK_period;
    test_in <= '0';
    test_addA <= "0010";
    test_addB <= "0001";  -- Assuming previous data was different
    WAIT FOR CK_period;

    ASSERT test_qa = X"C3"
    REPORT "Error in Test 3: Simultaneous read/write test failed"
    SEVERITY error;

    -- Complete the test
    WAIT;
end process;

end Behavioral;
