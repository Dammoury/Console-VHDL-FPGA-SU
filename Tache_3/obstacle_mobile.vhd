-- Generation du Decor et Gestion de l'Obstacle du Jeu Pong
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity decor is
    Port (	clk25: in STD_LOGIC;								-- Horloge 25 MHz
				reset: in STD_LOGIC;								-- Reset Asynchrone
				
				-- INDICATIONS D'AFFICHAGE DES PIXELS
				endframe: in  STD_LOGIC;						-- Fin de l'Image Visible 
				xpos : in  STD_LOGIC_VECTOR (9 downto 0);	-- Coordonnee X du Pixel Courant
				ypos : in  STD_LOGIC_VECTOR (9 downto 0);	-- Coordonnee Y du Pixel Courant
				
				-- PARAMETRES DE JEU
				game_type: in STD_LOGIC;						-- Type de Jeu
				obstacle: in STD_LOGIC;							-- Parametre Obstacle
			  
				-- ELEMENTS DE DECOR
				bluebox : out  STD_LOGIC;						-- Pixel Courant = Case Bleue
				left: out STD_LOGIC;								-- Pixel Courant = Gauche de l'Ecran
				right: out STD_LOGIC;							-- Pixel Courant = Droite de l'Ecran
				bottom : out  STD_LOGIC;						-- Pixel Courant = Bas de l'Ecran
				barrier: out std_logic;							-- Pixel Courant = Obstacle (Jeu Pong)
				wall_top : out  STD_LOGIC;						-- Pixel Courant = Mur du Haut
				wall_bottom : out  STD_LOGIC;					-- Pixel Courant = Mur du Bas
				wall_left : out  STD_LOGIC;					-- Pixel Courant = Mur de Gauche
				wall_right : out  STD_LOGIC;					-- Pixel Courant = Mur de Droite
				wall_pong : out  STD_LOGIC;					-- Pixel Courant = Mur Jeu Casse Briques
				wall_brick : out  STD_LOGIC);					-- Pixel Courant = Mur Jeu Pong
end decor;

architecture Behavioral of decor is
--on a changé le type du signal ybarrier 
signal ybarrier: std_logic_vector(8 downto 0);	-- Coordonnees Y du Pixel dans la Zone de l'Obstacle
signal xbarrier: std_logic_vector(9 downto 0);	-- Corrdonnees en X de l'Obstacle
signal direction: std_logic;					-- Sens de Deplacement de l'Obstacle

begin

-------------------------------------------------------------------------------------------

	-- GESTION DU DECOR
		-- Damier Bleu et Noir de Fond d'Ecran
		-- Generation des Murs (En Fonction du Jeu Choisi)
		-- Signal de Bas de l'Ecran
	process (xpos,ypos,game_type)

	begin

		wall_pong	<= '0';
		wall_brick	<= '0';
		wall_left	<=	'0';
		wall_right	<=	'0';
		wall_top 	<=	'0';
		wall_bottom	<=	'0';
		left			<= '0';
		right			<= '0';
		bottom 		<=	'0';
		bluebox		<=	'0';

		
		-- Delimitation des Cases Bleues
			-- Tous les 32x32 Pixels
		bluebox <= xpos(3) xor ypos(3);
		
		
		-- Mur Haut (Present dans Pong et Casse Briques)
		if (ypos < 4) then 
			wall_top <= '1'; wall_brick <= '1'; wall_pong <= '1';
		end if;

		-- Si on Joue au Casse Briques
		if game_type = '0' then
			
			-- Mur Gauche
			if (xpos <= 4) then 
				wall_left <= '1'; wall_brick <= '1';
			end if;
		
			-- Mur Droit
			if (xpos > 635) then 
				wall_right <= '1'; wall_brick <= '1';
			end if;
	
			-- Bas de l'ecran
			if (ypos > 475) then 
				bottom <= '1'; 
			end if;
						
		-- Si on Joue a Pong
		else

			-- Mur du Bas
			if (ypos > 475) then 
				wall_bottom <= '1'; wall_pong <= '1';
			end if;

			-- Bord Gauche de L'Ecran
			if (xpos <= 4) then 
				left <= '1';
			end if;
		
			-- Bord Droit de l'Ecran
			if (xpos > 635) then 
				right <= '1';
			end if;


		end if;
	
	end process;

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

	-- Nous avons modifié cette partie pendant le TP pour génerer l'obstacle mobile dans le module decor

ybarrier <= "011101100"; -- 236 (position centrale en ordonnée pour un écran VGA)

-- Mise à jour de la position à chaque image
process(clk25, reset)
begin
  if reset = '0' then
        xbarrier  <= "0100001110"; -- 270
        direction <= '0';          -- vers la droite
  elsif rising_edge(clk25) then
        if endframe = '1' then
            if direction = '0' then  -- vers la droite
        -- si on est à (x_max - 2) ou plus, on rebondit
                if xbarrier >= "1000010101" then -- 533 = 535-2
                    direction <= '1';
                    xbarrier  <= xbarrier - "0000000010";
                else
                    xbarrier  <= xbarrier + "0000000010";
                end if;

            else                      -- vers la gauche
                -- si on est à (x_min + 2) ou moins, on rebondit
                if xbarrier <= "0000000111" then -- 7 = 5+2
                   direction <= '0';
                   xbarrier  <= xbarrier + "0000000010";
                else
                   xbarrier  <= xbarrier - "0000000010";
                end if;
            end if;
        end if;
  end if;
end process;


-- Commande Barrier: jeu Casse-Briques + obstacle ON + pixel dans rectangle (X et Y) (--xpos ? [xbarrier ; xbarrier+100[)
barrier <= '1' when (game_type = '0') and (obstacle = '1')
                 and (xpos >= xbarrier) and (xpos < (xbarrier + "0001100100"))
                 and (ypos >= ("0" & ybarrier)) and (ypos < (("0" & ybarrier) + "0000001000"))
           else '0';
end Behavioral;
