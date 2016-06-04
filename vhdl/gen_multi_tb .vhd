library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gen_multi_tb is
end entity gen_multi_tb;

architecture RTL of gen_multi_tb is
	constant BREITE : positive := 8;
	
	signal clk : std_logic;
	signal a : std_logic_vector(BREITE - 1 downto 0);
	signal b : std_logic_vector(BREITE - 1 downto 0);
	signal q : std_logic_vector(BREITE * 2 - 1 downto 0);
begin
	
	gen_multi :entity work.gen_multi
		generic map(
			BREITE => BREITE
		)
		port map(
			a => a,
			b => b,
			q => q
		);
	
	clock_driver : process
		constant period : time := 10 ns;
	begin
		clk <= '0';
		wait for period / 2;
		clk <= '1';
		wait for period / 2;
	end process clock_driver;
	
	stim_proc : process is
	begin
		wait for 5 ns;
		a <= std_logic_vector(to_unsigned(12,BREITE));
		b <= std_logic_vector(to_unsigned(8,BREITE));
		wait for 5 ns;
		a <= std_logic_vector(to_unsigned(0,BREITE));
		b <= std_logic_vector(to_unsigned(8,BREITE));
		wait for 5 ns;
		a <= std_logic_vector(to_unsigned(255,BREITE));
		b <= std_logic_vector(to_unsigned(3,BREITE));
		wait for 5 ns;
		a <= std_logic_vector(to_unsigned(255,BREITE));
		b <= std_logic_vector(to_unsigned(255,BREITE));
	end process stim_proc;
	
	
end architecture RTL;
