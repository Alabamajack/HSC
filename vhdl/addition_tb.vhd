library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity addition_tb is
end entity addition_tb;

architecture RTL of addition_tb is
	constant BREITE : positive := 8;
	
	signal a : std_logic_vector(BREITE - 1 downto 0);
	signal b : std_logic_vector(BREITE - 1 downto 0);
	signal q : std_logic_vector(BREITE - 1 downto 0);

	
begin
	
	addierer :entity work.gen_addition
		generic map(
			BREITE => BREITE
		)
		port map(
			a => a,
			b => b,
			q => q
		);
		
	stim_proc : process is
	begin
		wait for 5 ns;
		a <= std_logic_vector(to_unsigned(100, BREITE));
		b <= std_logic_vector(to_unsigned(100, BREITE));
		wait for 5 ns;
		a <= std_logic_vector(to_unsigned(0, BREITE));
		b <= std_logic_vector(to_unsigned(0, BREITE));
		wait for 5 ns;
		a <= std_logic_vector(to_unsigned(255, BREITE));
		b <= std_logic_vector(to_unsigned(1, BREITE));
		wait for 5 ns;
		a <= std_logic_vector(to_unsigned(150, BREITE));
		b <= std_logic_vector(to_unsigned(150, BREITE));
		wait for 5 ns;
		a <= std_logic_vector(to_unsigned(12, BREITE));
		b <= std_logic_vector(to_unsigned(13, BREITE));
	end process stim_proc;
	
	
end architecture RTL;
