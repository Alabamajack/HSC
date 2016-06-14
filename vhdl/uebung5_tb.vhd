library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uebung5_tb is
end entity uebung5_tb;

architecture RTL of uebung5_tb is
	constant period : time := 10 ns;

	signal clk : std_logic;
	signal rst : std_logic;
	signal a   : integer := 20;
	signal b   : integer := 30;
	signal c   : integer := 5;
	signal d   : integer := 3;
	signal e   : integer := 2;
	signal x   : integer := 1000;
	signal z   : integer;
	signal y   : integer;

begin
	uebung5 : entity work.uebung_5
		port map(
			clk => clk,
			rst => rst,
			a   => a,
			b   => b,
			c   => c,
			d   => d,
			e   => e,
			x   => x,
			y   => y,
			z   => z
		);

	clock_driver : process
	begin
		clk <= '0';
		wait for period / 2;
		clk <= '1';
		wait for period / 2;
	end process clock_driver;
	
	stim_proc : process is
	begin
		rst <= '1';
		wait for 5 ns;
		rst <= '0';
		wait;
	end process stim_proc;
	
	

end architecture RTL;
