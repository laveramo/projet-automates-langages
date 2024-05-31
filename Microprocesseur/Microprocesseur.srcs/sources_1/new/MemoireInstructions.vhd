----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/24/2024 03:30:17 PM
-- Design Name: 
-- Module Name: MemoireInstructions - Behavioral
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

entity MemoireInstructions is
    Port ( ADRESSE : in STD_LOGIC_VECTOR (7 downto 0 );
           CLK : in STD_LOGIC;
           D_OUT : out STD_LOGIC_VECTOR (31 downto 0));
end MemoireInstructions;

architecture Behavioral of MemoireInstructions is
    type mem_array is array (0 to 1023) of std_logic_vector(31 downto 0);
    signal memory : mem_array := (others => (others => '0'));
begin
    memory(0) <= x"06000100"; --AFC reg0 1
    memory(1) <= x"06010200"; --AFC reg1 2
    memory(2) <= x"06020300"; --AFC reg2 3
    memory(3) <= x"06030400"; --AFC reg3 4
    memory(4) <= x"01020001"; --ADD reg2 reg0 reg1
    memory(5) <= x"02020001"; --MUL reg2 reg0 reg1
    memory(6) <= x"05000100"; --COP reg0 reg1
    memory(7) <= x"08000000"; --STORE mem0 reg0
    memory(8) <= x"07000000"; --LOAD reg0 mem0
    
    process (clk)
    begin
        if rising_edge(clk) then
            D_OUT <= memory(conv_integer(ADRESSE));
        end if;
    end process;


end Behavioral;
