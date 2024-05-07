-- FILEPATH: /c:/Users/valey/OneDrive/Documentos/INSA/Architecture Mat/ALU/ALU.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
  port (
    -- Operandos de 8 bits
    Num1 : in std_logic_vector(7 downto 0);
    Num2 : in std_logic_vector(7 downto 0);

    -- Salida de 8 bits
    Res : out std_logic_vector(7 downto 0);

    -- Selección de operación (3 bits)
    OP : in std_logic_vector(2 downto 0);

    -- Bandera de acarreo, overflow (multiplicación) y negativo (resultado negativo)
    Carry : out std_logic;
    Overflow : out std_logic;
    Negative : out std_logic
  );
end entity ALU;
architecture Behavioral of ALU is

signal tmp : std_logic_vector(15 downto 0) := (others => '0'); -- Variable temporal para el acarreo

begin
-- Proceso de la ALU
  process(Num1, Num2, OP)
    begin
        case OP is
        when "000" => -- Suma
            Res <= Num1 + Num2;
        when "001" => -- Resta
            Res <= Num1 - Num2;
        when "010" => -- Multiplicación
            tmp <= Num1 * Num2;
            
        when "100" => -- AND
            Res <= Num1 and Num2;
        when "101" => -- OR
            Res <= Num1 or Num2;
        when "110" => -- XOR
            Res <= Num1 xor Num2;
        when "111" => -- NOT
            Res <= not Num1;
        when others =>
            Res <= (others => 'X');
        end case;
        
        -- Carry        
        if(tmp(15 downto 8) >= "00000001") then Carry <= '1'; else Carry <= '0'; end if;
        
        -- Overflow
        if(tmp(15 downto 8) >= X"FF") then Overflow <= '1'; else Overflow <= '0'; end if;
        
        -- Negative
        if(Num1 < Num2) then Negative <= '1'; else Negative <= '0'; end if;
        if(OP="010") then Res <= tmp(7 downto 0); end if;
  end process;
    
end architecture Behavioral;
