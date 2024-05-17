----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2024 08:41:03 AM
-- Design Name: 
-- Module Name: MemoireDonnees - Behavioral
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

entity MemoireDonnees is
    Port ( ADRESSE : in STD_LOGIC_VECTOR (7 downto 0 );
           D_IN : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           D_OUT : out STD_LOGIC_VECTOR (0 downto 7));
end MemoireDonnees;

architecture Behavioral of MemoireDonnees is
    type mem_array is array (0 to 255) of std_logic_vector(7 downto 0);
    signal memory : mem_array := (others => (others => '0'));
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '0' then
                memory <= (others => (others => '0'));
            elsif rw = '0' then
                memory(conv_integer(ADRESSE)) <= D_IN;
            end if;
            D_OUT <= memory(conv_integer(ADRESSE));
        end if;
    end process;


end Behavioral;
