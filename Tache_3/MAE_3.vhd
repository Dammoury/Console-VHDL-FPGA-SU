library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.all;

entity MAE_3 is
    Port (
    Pause_Rqt, Endframe, Lost, No_Brick,Fin_Tempo_Pause_MAE,Clk25, Reset: in std_logic;
    Timer_Lost_MAE : in std_logic_vector(5 downto 0);
    Brick_Win, Pause, RAZ_Tempo_Pause_MAE, Update_Tempo_Pause_MAE, Load_Timer_Lost_MAE, Update_Timer_Lost_MAE : out std_logic
    );
end MAE_3;

architecture Moore of MAE_3 is
type etat is(E0,E1,E2,E3,E4,E5,E6,E7);
signal EP,EF: etat;
begin

process(Clk25,Reset) -- Registre d'états
    begin
    if reset= '0' then EP <= E0;
    elsif rising_edge(Clk25) then EP <=EF;
    end if;
end process;

process(EP, Pause_Rqt, Endframe, Lost, No_Brick,Fin_Tempo_Pause_MAE,Timer_Lost_MAE) --Combinatoire des états
    begin
    case(EP) is
        when E0 => EF <=E0; if Pause_Rqt='1' then EF <= E1;end if;
        when E1 => EF <=E1;if (Fin_Tempo_Pause_MAE='1') and (Pause_Rqt='0') then EF <= E2;end if;
        when E2 => EF <=E2; 
            if Pause_Rqt='1' then 
                EF <= E3;
            elsif No_Brick='1' then 
                EF <= E4;
            elsif Lost='1' then
                EF <= E5;
           end if;
        when E3 => EF <=E3; if( Fin_Tempo_Pause_MAE='1') and (Pause_Rqt='0') then EF <= E0;end if;
        when E4 => EF <=E4; 
        when E5 => EF <=E5; if Timer_Lost_MAE= "111111" then EF <= E6;end if;
        when E6 => EF <=E6; if (Endframe='1') and (not(Timer_Lost_MAE="000000")) then EF <= E7;end if;
        when E7 => EF <=E6;
        when others => EF <= EP;
        end case;
end process;

process(EP) --Combinatoire des Sorties
    begin
    case(EP) is
        when E0 => Brick_Win <= '0'; Pause<= '1'; RAZ_Tempo_Pause_MAE<= '1'; Update_Tempo_Pause_MAE<= '0';
        Load_Timer_Lost_MAE<= '0'; Update_Timer_Lost_MAE<= '0';
        when E1 =>Brick_Win <= '0'; Pause<= '0'; RAZ_Tempo_Pause_MAE<= '0'; Update_Tempo_Pause_MAE<= '1';
        Load_Timer_Lost_MAE<= '0'; Update_Timer_Lost_MAE<= '0';
        when E2 => Brick_Win <= '0'; Pause<= '0'; RAZ_Tempo_Pause_MAE<= '1'; Update_Tempo_Pause_MAE<= '0';
        Load_Timer_Lost_MAE<= '0'; Update_Timer_Lost_MAE<= '0';
        when E3 => Brick_Win <= '0'; Pause<= '0'; RAZ_Tempo_Pause_MAE<= '0'; Update_Tempo_Pause_MAE<= '1';
        Load_Timer_Lost_MAE<= '0'; Update_Timer_Lost_MAE<= '0';
        when E4 => Brick_Win <= '1'; Pause<= '0'; RAZ_Tempo_Pause_MAE<= '0'; Update_Tempo_Pause_MAE<= '0';
        Load_Timer_Lost_MAE<= '0'; Update_Timer_Lost_MAE<= '0';
        when E5 => Brick_Win <= '0'; Pause<= '0'; RAZ_Tempo_Pause_MAE<= '0'; Update_Tempo_Pause_MAE<= '0';
        Load_Timer_Lost_MAE<= '1'; Update_Timer_Lost_MAE<= '0';
        when E6 => Brick_Win <= '0'; Pause<= '0'; RAZ_Tempo_Pause_MAE<= '0'; Update_Tempo_Pause_MAE<= '0';
        Load_Timer_Lost_MAE<= '0'; Update_Timer_Lost_MAE<= '0';
        when E7 => Brick_Win <= '0'; Pause<= '0'; RAZ_Tempo_Pause_MAE<= '0'; Update_Tempo_Pause_MAE<= '0';
        Load_Timer_Lost_MAE<= '0'; Update_Timer_Lost_MAE<= '1';
    end case;
end process;
end Moore;
