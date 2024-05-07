----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2024 10:01:12 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
  Port(
    -- Operandos de 8 bits
    A : in std_logic_vector(7 downto 0);
    B : in std_logic_vector(7 downto 0);

    -- Salida de 8 bits
    S : out STD_LOGIC_VECTOR (7 downto 0);

    -- Selección de operación (3 bits)
    OP : in std_logic_vector(2 downto 0);

    -- Bandera de acarreo, overflow (multiplicación) y negativo (resultado negativo)
    Carry : out std_logic;
    Overflow : out std_logic;
    Negative : out std_logic
  );
end ALU;

architecture Behavioral of ALU is
begin
-- Proceso de la ALU
  process(A, B, OP)
  variable tmp : std_logic_vector(8 downto 0); -- Variable temporal para el acarreo
    begin
        case OP is
        -- Suma
        when "000" => 
            -- Suma de A y B con acarreo de 1 bit
            tmp := A + B; 
            S <= tmp(7 downto 0);
            -- Acarreo de la suma (bit 8)
            Carry <= tmp(8);
            -- Overflow si los signos de A y B son iguales y el signo de S es diferente
            Overflow <= '1' when (A(7) = B(7) and S(7) /= A(7)) else '0'; 
            Negative <= S(7);
        when "001" => -- Resta
            tmp := A - B; -- Resta de A y B con acarreo de 1 bit
            S <= tmp(7 downto 0);
            Carry <= not tmp(8); -- Acarreo de la resta (bit 8) es el inverso del acarreo de la suma
            Overflow <= '0';
            Negative <= S(7);
        when "010" => -- Multiplicación
            S <= A * B;
            Carry <= '0';
            Overflow <= '1' when (A(7) /= B(7) and S(7) /= A(7)) else '0'; -- Overflow si los signos de A y B son diferentes y el signo de S es diferente
            Negative <= S(7);
        when "011" => -- División
            S <= A / B;
            Carry <= '0';
            Overflow <= '0';
            Negative <= S(7);
        when "100" => -- AND
            S <= A and B;
            Carry <= '0'; -- No hay carry en operaciones lógicas
            Overflow <= '0';  -- No hay overflow en operaciones lógicas
            Negative <= '0'; -- No hay negativo en operaciones lógicas
        when "101" => -- OR
            S <= A or B;
            Carry <= '0';
            Overflow <= '0';
            Negative <= '0';
        when "110" => -- XOR
            S <= A xor B;
            Carry <= '0';
            Overflow <= '0';
            Negative <= '0';
        when "111" => -- NOT
            S <= not A;
            Carry <= '0';
            Overflow <= '0';
            Negative <= '0';
        when others =>
            S <= (others => 'X');
            Carry <= 'X';
            Overflow <= 'X';
            Negative <= 'X';
        end case;
  end process;

end architecture Behavioral;