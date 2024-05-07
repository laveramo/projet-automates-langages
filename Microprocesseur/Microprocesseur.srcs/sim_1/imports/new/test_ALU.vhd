----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2024 02:10:14 PM
-- Design Name: 
-- Module Name: test_ALU - Behavioral
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

entity test_ALU is
end test_ALU;

architecture Behavioral of test_ALU is
component ALU
    Port (  -- Operandos de 8 bits
        Num1 : in std_logic_vector(7 downto 0);
        Num2 : in std_logic_vector(7 downto 0);
    
        -- Salida de 8 bits
        Res : out std_logic_vector(7 downto 0);
    
        -- Selección de operación (3 bits)
        OP : in std_logic_vector(2 downto 0);
    
        -- Bandera de acarreo, overflow (multiplicación) y negativo (resultado negativo)
        Carry : out std_logic;
        Overflow : out std_logic;
        Negative : out std_logic);
end component;

-- Signals pour tester
signal test_num1 : std_logic_vector(7 downto 0);
signal test_num2 : std_logic_vector(7 downto 0);
signal test_res : std_logic_vector(7 downto 0);
signal test_op : std_logic_vector(2 downto 0);
signal test_carry, test_overflow, test_negative : std_logic;

begin
-- Unit Under Test
test_alu : ALU PORT MAP (
    Num1 => test_num1,
    Num2 => test_num2,
    Res => test_res,
    OP => test_op,
    Carry => test_carry,
    Overflow => test_overflow,
    Negative => test_negative
);

-- Calcul process
process
begin

    -- Suma
    test_op <= "000";
    test_num1 <= "00000010";
    test_num2 <= "00000001";
    wait for 10ns;
    
    -- Resta
    test_op <= "001";
    test_num1 <= "00000010";
    test_num2 <= "00000001";
    wait for 10ns;
    
    -- Mult
    test_op <= "010";
    test_num1 <= "00000011";
    test_num2 <= "00001001";
    wait for 10ns;
    
    -- AND
    test_op <= "100";
    test_num1 <= "00000010";
    test_num2 <= "00000001";
    wait for 10ns;
    
    -- OR
    test_op <= "101";
    test_num1 <= "00000010";
    test_num2 <= "00000001";
    wait for 10ns;
    
    -- XOR
    test_op <= "110";
    test_num1 <= "00000010";
    test_num2 <= "00000001";
    wait for 10ns;
    
    -- NOT
    test_op <= "111";
    test_num1 <= "00000010";
    test_num2 <= "00000001";
    wait for 10ns;
    
end process;

end Behavioral;
