----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/26/2024 06:50:54 PM
-- Design Name: 
-- Module Name: test_MemoireInstructions - Behavioral
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

entity test_MemoireInstructions is
--  Port ( );
end test_MemoireInstructions;

architecture Behavioral of test_MemoireInstructions is
    -- Component declaration of the entity under test (UUT)
    component MemoireInstructions
        Port ( ADRESSE : in STD_LOGIC_VECTOR (7 downto 0);
               CLK : in STD_LOGIC;
               D_OUT : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

    -- Signals to connect to UUT
    signal ADRESSE : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal CLK : STD_LOGIC := '0';
    signal D_OUT : STD_LOGIC_VECTOR (31 downto 0);

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: MemoireInstructions
        Port map (
            ADRESSE => ADRESSE,
            CLK => CLK,
            D_OUT => D_OUT
        );

    -- Clock process definitions
    CLK_process : process
    begin
        CLK <= '0';
        wait for CLK_PERIOD/2;
        CLK <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin

        -- Read from address '00000001' after initialization
        ADRESSE <= "00000001";
        wait for CLK_PERIOD;
        assert (D_OUT = "00000000000000000000000000000111")
        report "Test failed for address 00000001 after initialization" severity error;

        -- Read from address '00000002' after initialization
        ADRESSE <= "00000010";
        wait for CLK_PERIOD;
        assert (D_OUT = "00000000000000000000000000001111")
        report "Test failed for address 00000010 after initialization" severity error;

        -- Read from address '00000003' after initialization
        ADRESSE <= "00000011";
        wait for CLK_PERIOD;
        assert (D_OUT = "00000000000000000000000000011111")
        report "Test failed for address 00000011 after initialization" severity error;

        -- End of test
        report "Testbench completed successfully" severity note;
        wait;
    end process;


end Behavioral;
