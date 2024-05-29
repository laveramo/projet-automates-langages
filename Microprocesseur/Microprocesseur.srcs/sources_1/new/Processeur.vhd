----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/28/2024 05:50:07 PM
-- Design Name: 
-- Module Name: Processeur - Behavioral
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

entity Processeur is
    Port ( clk : in STD_LOGIC;
           ip :  in STD_LOGIC_VECTOR (7 downto 0 );
           rst: in STD_LOGIC
            );
end Processeur;

architecture Struct of Processeur is
    component MemoireInstructions
    Port (
        ADRESSE : in STD_LOGIC_VECTOR (7 downto 0 );
        CLK : in STD_LOGIC;
        D_OUT : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component BancRegistres
    Port (  
        CLK : in STD_LOGIC; -- Horloge
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
    
    component ALU
    Port (
        Num1 : in std_logic_vector(7 downto 0);
        Num2 : in std_logic_vector(7 downto 0);
        Res : out std_logic_vector(7 downto 0);
        OP : in std_logic_vector(2 downto 0);
        Carry : out std_logic;
        Overflow : out std_logic;
        Negative : out std_logic
        );
    end component;
    
    component MemoireDonnees
    Port ( 
        ADRESSE : in STD_LOGIC_VECTOR (7 downto 0 );
       D_IN : in STD_LOGIC_VECTOR (7 downto 0);
       RW : in STD_LOGIC;
       RST : in STD_LOGIC;
       CLK : in STD_LOGIC;
       D_OUT : out STD_LOGIC_VECTOR (7 downto 0)
       );
    end component;
    
    component Pipeline
    Port (
        clk : in std_logic;
        rst : in std_logic;
        -- Ports pour la mémoire d'instructions
        instr_data : in std_logic_vector(31 downto 0);
        -- Ports pour le banc de registres
        reg_W : out STD_LOGIC;   -- Signal d'écriture
        reg_ADD_A : out STD_LOGIC_VECTOR (3 downto 0); -- Adresse de lecture A
        reg_ADD_B: out STD_LOGIC_VECTOR (3 downto 0);  -- Adresse de lecture B
        reg_ADD_W : out STD_LOGIC_VECTOR (3 downto 0); -- Adresse d'écriture
        reg_DATA : out STD_LOGIC_VECTOR(7 downto 0);   -- Données à écrire
        reg_QA : in STD_LOGIC_VECTOR (7 downto 0);   -- Sortie des données pour A
        reg_QB : in STD_LOGIC_VECTOR (7 downto 0);    -- Sortie des données pour 
        --Ports pour l'ALU
        alu_Num1 : out std_logic_vector(7 downto 0);
        alu_Num2 : out std_logic_vector(7 downto 0);
        alu_Res : in std_logic_vector(7 downto 0);
        alu_OP : out std_logic_vector(2 downto 0);
        -- Ports pour la mémoire de données
        data_addr : out std_logic_vector(7 downto 0);
        data_in : out std_logic_vector(7 downto 0);
        data_out : in std_logic_vector(7 downto 0);
        data_rw : out std_logic -- 1 pour lecture, 0 pour écriture
    );
end component;
signal instructions : std_logic_vector(31 downto 0);
signal signal_W : std_logic;
signal signal_reg_ADD_A : STD_LOGIC_VECTOR (3 downto 0); -- Adresse de lecture A
signal signal_reg_ADD_B : STD_LOGIC_VECTOR (3 downto 0);  -- Adresse de lecture B
signal signal_reg_ADD_W : STD_LOGIC_VECTOR (3 downto 0); -- Adresse d'écriture
signal signal_reg_DATA : STD_LOGIC_VECTOR(7 downto 0);   -- Données à écrire
signal signal_reg_QA : STD_LOGIC_VECTOR (7 downto 0);   -- Sortie des données pour A
signal signal_reg_QB : STD_LOGIC_VECTOR (7 downto 0);
signal signal_alu_Num1 : std_logic_vector(7 downto 0);
signal signal_alu_Num2 : std_logic_vector(7 downto 0);
signal signal_alu_Res : std_logic_vector(7 downto 0);
signal signal_alu_OP : std_logic_vector(2 downto 0);
signal signal_data_addr : std_logic_vector(7 downto 0);
signal signal_data_in : std_logic_vector(7 downto 0);
signal signal_data_out : std_logic_vector(7 downto 0);
signal signal_data_rw : std_logic; -- 1 pour lecture, 0 pour écriture

begin
    pipe: Pipeline port map (clk,rst,instructions,signal_W,signal_reg_ADD_A,signal_reg_ADD_B,signal_reg_ADD_W,signal_reg_DATA,signal_reg_QA, signal_reg_QB,signal_alu_Num1,signal_alu_Num2,signal_alu_Res,signal_alu_OP,signal_data_addr,signal_data_in,signal_data_out,signal_data_rw);
    mem_ins: MemoireInstructions port map(ip,clk,instructions);
    registres: BancRegistres port map(clk,rst,signal_W,signal_reg_ADD_A,signal_reg_ADD_B,signal_reg_ADD_W,signal_reg_DATA,signal_reg_QA,signal_reg_QB);
    ual: ALU port map(signal_alu_Num1, signal_alu_Num2,signal_alu_Res, signal_alu_OP);
    mem_don: MemoireDonnees port map(signal_data_addr, signal_data_in, signal_data_rw, rst, clk, signal_data_out);

end Struct;
