----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2024 10:24:43 AM
-- Design Name: 
-- Module Name: test_Processeur - Behavioral
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

entity test_Processeur is
end test_Processeur;

architecture Behavioral of test_Processeur is
    component Processeur
        Port(
            clk : in STD_LOGIC;
            ip :  in STD_LOGIC_VECTOR (7 downto 0 );
            rst: in STD_LOGIC
            );
     end component;
     
    signal test_CLK: std_logic;
    signal test_ip: std_logic_vector (7 downto 0);
    signal test_rst: std_logic;
    constant CLK_PERIOD : time := 10 ns;
      
begin

test_processeur: Processeur port map(
    clk => test_CLK,
    ip => test_ip,
    rst => test_rst
    );
    
    CLK_process : process
    begin
        test_CLK <= '0';
        wait for CLK_PERIOD/2;
        test_CLK <= '1';
        wait for CLK_PERIOD/2;
    end process;

    process
    begin
        test_rst <= '1';
        
        -- start to reading instructions
        test_rst <= '1';
        test_ip <= "00000000";
        wait for CLK_PERIOD;
       
        test_ip <= "00000001";
        wait for CLK_PERIOD;
        
        test_ip <= "00000010";
        wait for CLK_PERIOD;
        
        test_ip <= "00000011";
        wait for CLK_PERIOD;
        
        test_ip <= "00000000";
        wait for CLK_PERIOD;
       
        test_ip <= "00000001";
        wait for CLK_PERIOD;
        
        test_ip <= "00000010";
        wait for CLK_PERIOD;
        
        test_ip <= "00000011";
         
    end process;
end Behavioral;
