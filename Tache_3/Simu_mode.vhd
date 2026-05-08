library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.all;

entity Simu_mode is
end Simu_mode;

architecture Behavioral of Simu_mode is
signal Clk25: std_logic := '0';
signal Reset, Pause_Rqt,Endframe, Lost, No_Brick,Game_Lost, Brick_Win, Pause : std_logic;
begin

Mode: entity work.mode
    port map(
    Clk25 => Clk25,
    Reset => Reset,
    Pause_Rqt => Pause_Rqt,
    Endframe => Endframe,
    Lost => Lost,
    No_Brick => No_Brick,
    Game_Lost => Game_Lost,
    Brick_Win => Brick_Win,
    Pause => Pause
    );
Clk25 <= not Clk25 after 20 ns;
--Reset <= '0', '1' after 100 ns; (possible aussi)
process
    begin
        Endframe <= '0';
        wait for 1 us; 
        Endframe <= '1'; -- Pulse actif
        wait for 40 ns;  -- Durée d'un cycle d'horloge
    end process;

    -- 4. Scénario principal (Linéaire, sans boucles)
    stim_proc: process
    begin
        -- === RESET ===
        Reset <= '0';
        wait for 100 ns;
        Reset <= '1';
        wait for 100 ns;

        -- === SORTIE DE PAUSE ===
        Pause_Rqt <= '1'; 
        -- On attend que le compteur Tempo_Pause (environ 41 us) finisse
        wait for 50 us;   
        Pause_Rqt <= '0';
        
        -- Ici, le signal 'Pause' doit être tombé à 0.

        -- === TEST PERDU (Game Over) ===
        wait for 5 us;
        Lost <= '1';      -- La balle est perdue
        wait for 40 ns;
        Lost <= '0';

        -- C'est ici que la boucle n'est plus nécessaire.
        -- Le Timer_Lost est chargé à 63. Il se décrémente à chaque pulse de Endframe.
        -- Comme notre process Endframe tourne tout seul toutes les 1 us,
        -- il suffit d'attendre un temps > 64 us (64 images).
        
        wait for 80 us; 
        
        -- Après ces 80us, le timer est fini, on doit être revenu en Pause.

        -- === VICTOIRE (No Brick) ===
        -- On relance le jeu d'abord (car on est retombé en pause)
        Pause_Rqt <= '1';
        wait for 50 us;
        Pause_Rqt <= '0';
        
        wait for 5 us;
        
        -- On gagne
        No_Brick <= '1';
        wait for 200 ns;
        -- Ici Brick_Win doit être à 1.

        wait; -- Fin du test
    end process;

end Behavioral;
