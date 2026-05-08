library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.all;

entity Tempo_Pause is
    Port ( RAZ_Tempo_Pause, Update_Tempo_Pause, Clk25, Reset : in std_logic;
    Fin_Tempo_Pause : out std_logic
    );
end Tempo_Pause;

architecture Behavioral of Tempo_Pause is
signal Val_max :std_logic_vector(9 downto 0) :="1111111111";
signal cpt : std_logic_vector(9 downto 0) :="0000000000";
begin
Fin_Tempo_Pause <= '1' when cpt = Val_max else '0';
    process(Clk25,Reset)
    begin
        if Reset= '0' then cpt <=(Others=>'0');
        elsif rising_edge(Clk25) then
            -- Conserver val préc.
            if  ((RAZ_Tempo_Pause='0') and (Update_Tempo_Pause='0')) or  
            ((RAZ_Tempo_Pause='1') and (Update_Tempo_Pause='1'))then
                cpt <= cpt;
            -- Incrémentation
            elsif  RAZ_Tempo_Pause= '0' and Update_Tempo_Pause ='1' then
                cpt <= cpt+1;
           -- Reset 
           elsif  (RAZ_Tempo_Pause ='1') and (Update_Tempo_Pause= '0') then
                cpt <= (Others => '0');
          end if;
        end if;
    end process;
end Behavioral;
