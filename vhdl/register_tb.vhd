library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_tb is
end entity register_tb;

architecture RTL of register_tb is
	constant BREITE : positive := 8;
	signal clk : std_logic;
	signal rst : std_logic;
	signal we : std_logic;
	signal a : std_logic_vector(BREITE - 1 downto 0);
	signal q : std_logic_vector(BREITE - 1 downto 0);
begin
	clock_driver : process
		constant period : time := 10 ns;
	begin
		clk <= '0';
		wait for period / 2;
		clk <= '1';
		wait for period / 2;
	end process clock_driver;
	
	gen_register :entity work.gen_register
		generic map(
			BREITE => BREITE
		)
		port map(
			clk => clk,
			rst => rst,
			we  => we,
			a   => a,
			q   => q
		);
	
	stim_process : process is
	begin
		rst <= '1';
		wait for 50 ns;
		rst <= '0';
		wait for 20 ns;
		we <= '1';
		a <= (others => '1');
		wait for 100 ns;
		we <= '0';
		wait for 20 ns;
		a <= "10101010";
		wait for 50 ns;
		a <= "00001111";
		wait for 50 ns;
		wait;
	end process stim_process;

end architecture RTL;
