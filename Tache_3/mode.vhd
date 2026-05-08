library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.all;

entity Mode is
    Port (
    Clk25,Reset, Pause_Rqt,Endframe, Lost, No_brick : in std_logic;
    Game_Lost, Brick_Win, Pause: out std_logic
    );
end Mode;

architecture Behavioral of mode is
--Signaux de la MAE
signal RAZ_Tempo_Pause_MAEs, Update_Tempo_Pause_MAEs, Load_Timer_Lost_MAEs, Update_Timer_Lost_MAEs : std_logic;
--Signaux de Tempo_Pause
signal Fin_Tempo_Pauses : std_logic;
--Signaux de Timer_Lost
signal Timer_Losts: std_logic_vector (5 downto 0);
begin

MAE3: entity work.MAE_3 
    port Map(
    Pause_Rqt => Pause_Rqt,
    Endframe => Endframe,
    Lost => Lost,
    No_Brick => No_Brick,
    Fin_Tempo_Pause_MAE => Fin_Tempo_Pauses,
    Timer_Lost_MAE => Timer_Losts,
    Clk25 => Clk25,
    Reset => Reset,
    Brick_Win => Brick_Win,
    Pause => Pause,
    RAZ_Tempo_Pause_MAE => RAZ_Tempo_Pause_MAEs,
    Update_Tempo_Pause_MAE => Update_Tempo_Pause_MAEs,
    Load_Timer_Lost_MAE => Load_Timer_Lost_MAEs,
    Update_Timer_Lost_MAE => Update_Timer_Lost_MAEs
    );
    
Tempo_Pause: entity work.Tempo_pause
    port map (
    RAZ_Tempo_Pause => RAZ_Tempo_Pause_MAEs,
    Update_Tempo_Pause => Update_Tempo_Pause_MAEs,
    Fin_Tempo_Pause => Fin_Tempo_Pauses,
    Clk25 => Clk25,
    Reset => Reset
    );
    
Timer_Lost: entity work.Timer_Lost
    port map(
    Load_Timer_Lost => Load_Timer_Lost_MAEs,
    Update_Timer_Lost => Update_Timer_Lost_MAEs,
    Clk25 => Clk25,
    Reset => Reset,
    Game_Lost => Game_Lost,
    Timer_Lost => Timer_Losts
    );
end Behavioral;
