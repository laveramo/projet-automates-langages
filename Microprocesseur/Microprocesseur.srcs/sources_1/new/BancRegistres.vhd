----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2024 02:20:41 PM
-- Design Name: 
-- Module Name: BancRegistres - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BancRegistres is
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
end BancRegistres;

architecture Behavioral of BancRegistres is
    type reg_array is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0); -- Tableau de registres
    signal registers : reg_array := (others => (others => '0')); -- Initialisation à 0
begin
    process(CLK, RST)
    begin
        if(RST='0') then    -- Le signal RST est activ
            registers <= (others => (others => '0')); -- Réinitialisation à 0 du tableau
        elsif (CLK='1') then
            if(W='1') then  -- Le signal d'éccriture est actif
                registers(conv_integer(ADD_W)) <= DATA;  -- écrire les données dans le registre spécifié par ADD_W
            end if;
        end if;
    end process;
    -- Lecture des données pour A et B
    QA <= registers(conv_integer(ADD_A));
    QB <= registers(conv_integer(ADD_B));

end Behavioral;