----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/24/2024 04:31:30 PM
-- Design Name: 
-- Module Name: Pipeline - Behavioral
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

entity Pipeline is
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
end Pipeline;

architecture Behavioral of Pipeline is

    -- Registres de pipeline
    type pipeline_stage is record
        OP : std_logic_vector(7 downto 0);
        A : std_logic_vector(7 downto 0);
        B : std_logic_vector(7 downto 0);
        C : std_logic_vector(7 downto 0);
        
    end record;

    signal LI_DI : pipeline_stage;
    signal DI_EX : pipeline_stage;
    signal EX_MEM : pipeline_stage;
    signal MEM_RE : pipeline_stage;

begin
    
    -- Etage 1: Decode (LI/DI)
    process(clk, rst)
    begin
        if rst = '0' then
            LI_DI <= (others => (others => '0'));
        elsif rising_edge(clk) then
            LI_DI.OP <= instr_data(31 downto 24);
            LI_DI.A <= instr_data(23 downto 16);
            LI_DI.B <= instr_data(15 downto 8);
            LI_DI.C <= instr_data(7 downto 0);
            reg_ADD_A <= LI_DI.B;
            reg_ADD_B <= LI_DI.C;
        end if;
    end process;

    -- Etage 2: Registres (DI/EX)
    process(clk, rst)
    begin
        if rst = '0' then
            DI_EX <= (others => (others => '0'));
        elsif rising_edge(clk) then
            DI_EX.OP <= LI_DI.OP;
            DI_EX.A <= LI_DI.A;

            case LI_DI.OP is
                when "00000001" => --ADD
                    DI_EX.B <= reg_QA;
                    DI_EX.C <= reg_QB;
                    alu_OP <= "000";
                 when "00000010" => --MUL
                    DI_EX.B <= reg_QA;
                    DI_EX.C <= reg_QB;
                    alu_OP <= "010";
                 when "00000011" => --SOU
                    DI_EX.B <= reg_QA;
                    DI_EX.C <= reg_QB;
                    alu_OP <= "001";
                 when "00000100" => --DIV
                    DI_EX.B <= reg_QA;
                    DI_EX.C <= reg_QB;
                    --alu_OP <= "000";
                  when "00000101" => -- COP
                    DI_EX.B <= reg_QA;
                    DI_EX.C <= reg_QB;
                when "00000110" => -- AFC
                    DI_EX.B <= LI_DI.B;
                when "00000111" => -- LOAD
                    DI_EX.B <= LI_DI.B;
                when "00001000" => -- STORE
                    DI_EX.B <= LI_DI.B;
                when others =>
                    null;
            end case;
            alu_Num1 <= DI_EX.B;
            alu_Num2 <= DI_EX.C;
        end if;
    end process;

    -- Etage 3: ALU
    process(clk, rst)
    begin
        if rst = '0' then
            EX_MEM <= (others => (others => '0'));
        elsif rising_edge(clk) then
            EX_MEM.OP <= DI_EX.OP;
            EX_MEM.A <= DI_EX.A;
        
            case DI_EX.OP is
                when "00000001" | "00000010" | "00000011" | "00000100" => -- ADD.MUL.SOU.DIV
                    EX_MEM.B <= alu_Res;
                when "00000101" | "00000110" => -- COP,AFC
                    EX_MEM.B <= DI_EX.B;
                when "00000111" => --LOAD
                    EX_MEM.B <= DI_EX.B;
                    data_addr <= EX_MEM.B;
                    data_rw <= '1';
                when "00001000" => -- STORE
                    EX_MEM.B <= DI_EX.B;
                    data_addr <= EX_MEM.A;
                    data_in <= EX_MEM.B;
                    data_rw <= '0';  
                when others =>
                    null;
            end case;
        end if;
    end process;

    -- Etage 4: Memoire de données
    process(clk, rst)
    begin
        if rst = '0' then
            MEM_RE <= (others => (others => '0'));
        elsif rising_edge(clk) then
        MEM_RE.OP <= EX_MEM.OP;
        MEM_RE.A <= EX_MEM.A;
            case EX_MEM.OP is
                when "00000111" | "00001000"  => --LOAD,STORE
                    MEM_RE.B <= data_out;      
                when others =>
                    MEM_RE.B <= EX_MEM.B; 
            end case;
        end if;
    end process;
    
    -- Etage 5: Write back
    process(clk, rst)
    begin
        if rst = '0' then
            MEM_RE <= (others => (others => '0'));
        elsif rising_edge(clk) then
            case MEM_RE.OP is
                when "00000001" | "00000010" | "00000011" | "00000100" | "00000101" | "00000110" | "00000111" => -- ALL EXCEPT STORE
                    reg_DATA <= MEM_RE.B;
                    reg_ADD_W <= MEM_RE.A;
                    reg_W <= '1';
            end case;
        end if;
    end process;


end Behavioral;
