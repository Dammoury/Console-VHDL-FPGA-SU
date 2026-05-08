library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.all;

entity Timer_Lost is
 Port ( Load_Timer_Lost, Update_Timer_Lost, Clk25, Reset : in std_logic;
    Game_Lost: out std_logic;
    Timer_Lost: out std_logic_vector(5 downto 0)
    );
end Timer_Lost;

architecture Behavioral of Timer_Lost is
signal Val_max_63 :std_logic_vector(5 downto 0) :="111111";
signal cpt : std_logic_vector(5 downto 0) :="000000";
begin
Game_Lost <= '1' when cpt >0 else '0';
Timer_Lost <= cpt;
    process(Clk25,Reset)
    begin
        if Reset= '0' then cpt <=(Others=>'0');
        elsif rising_edge(clk25) then
            -- Conserver val préc.
            if  ((Load_Timer_Lost='0') and (Update_Timer_Lost='0')) or 
            ((Load_Timer_Lost='1') and (Update_Timer_Lost='1')) then
                cpt <= cpt;
            -- Décrémentation
            elsif  Load_Timer_Lost= '0' and Update_Timer_Lost ='1' then
                cpt <= cpt-1;
           -- Chargement parallèle à Val_Max_63
           elsif  Load_Timer_Lost ='1' and Update_Timer_Lost= '0' then
                cpt <= Val_Max_63;
          end if;
        end if;
    end process;
end Behavioral;
