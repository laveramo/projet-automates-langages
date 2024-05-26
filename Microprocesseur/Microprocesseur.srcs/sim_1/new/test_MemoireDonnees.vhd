----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/26/2024 06:34:51 PM
-- Design Name: 
-- Module Name: test_MemoireDonnees - Behavioral
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

entity test_MemoireDonnees is
--  Port ( );
end test_MemoireDonnees;

architecture Behavioral of test_MemoireDonnees is

-- Component declaration of the entity under test (UUT)
    component MemoireDonnees
        Port ( ADRESSE : in STD_LOGIC_VECTOR (7 downto 0);
               D_IN : in STD_LOGIC_VECTOR (7 downto 0);
               RW : in STD_LOGIC;
               RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               D_OUT : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    -- Signals to connect to UUT
    signal ADRESSE : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal D_IN : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal RW : STD_LOGIC := '1';
    signal RST : STD_LOGIC := '1';
    signal CLK : STD_LOGIC := '0';
    signal D_OUT : STD_LOGIC_VECTOR (7 downto 0);

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: MemoireDonnees
        Port map (
            ADRESSE => ADRESSE,
            D_IN => D_IN,
            RW => RW,
            RST => RST,
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
        -- Initialize Inputs
        ADRESSE <= (others => '0');
        D_IN <= (others => '0');
        RW <= '1';
        RST <= '1';

        -- Wait 100 ns for global reset to finish
        wait for 100 ns;

        -- Apply reset
        RST <= '0';
        wait for CLK_PERIOD;
        RST <= '1';
        wait for CLK_PERIOD;

        -- Write '10101010' to address '00000001'
        ADRESSE <= "00000001";
        D_IN <= "10101010";
        RW <= '0';
        wait for CLK_PERIOD;

        -- Read from address '00000001'
        RW <= '1';
        wait for CLK_PERIOD;
        assert (D_OUT = "10101010")
        report "Test failed for address 00000001" severity error;

        -- Write '01010101' to address '00000010'
        ADRESSE <= "00000010";
        D_IN <= "01010101";
        RW <= '0';
        wait for CLK_PERIOD;

        -- Read from address '00000010'
        RW <= '1';
        wait for CLK_PERIOD;
        assert (D_OUT = "01010101")
        report "Test failed for address 00000010" severity error;

        -- Apply reset and check if memory is cleared
        RST <= '0';
        wait for CLK_PERIOD;
        RST <= '1';
        wait for CLK_PERIOD;

        -- Read from address '00000001' after reset
        ADRESSE <= "00000001";
        RW <= '1';
        wait for CLK_PERIOD;
        assert (D_OUT = "00000000")
        report "Test failed after reset for address 00000001" severity error;

        -- Read from address '00000010' after reset
        ADRESSE <= "00000010";
        RW <= '1';
        wait for CLK_PERIOD;
        assert (D_OUT = "00000000")
        report "Test failed after reset for address 00000010" severity error;

        -- End of test
        report "Testbench completed successfully" severity note;
        wait;
    end process;


end Behavioral;
