library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity uebung_5 is
	port(
		clk           : in  std_logic;
		rst           : in  std_logic;
		a, b, c, d, e : in  integer;
		y, z          : out integer
	);
end entity uebung_5;

architecture RTL of uebung_5 is
	constant BREITE : natural := 32;
	constant INPUTS : natural := 2;

	component gen_addition
		generic(BREITE : positive := 8);
		port(a : in  std_logic_vector(BREITE - 1 downto 0);
			 b : in  std_logic_vector(BREITE - 1 downto 0);
			 q : out std_logic_vector(BREITE - 1 downto 0));
	end component gen_addition;

	component gen_mux
		generic(INPUTS : positive := 8;
			    WIDTH  : positive := 8);
		port(input_arr : in  std_logic_vector(INPUTS * WIDTH - 1 downto 0);
			 s         : in  std_logic_vector(integer(floor(log2(real(INPUTS)) + 0.5)) - 1 downto 0);
			 q         : out std_logic_vector(WIDTH - 1 downto 0));
	end component gen_mux;

	component gen_sub
		generic(BREITE : natural := 8);
		port(a : in  std_logic_vector(BREITE - 1 downto 0);
			 b : in  std_logic_vector(BREITE - 1 downto 0);
			 q : out std_logic_vector(BREITE - 1 downto 0));
	end component gen_sub;

	component gen_multi
		generic(BREITE : positive := 8);
		port(a : in  std_logic_vector(BREITE - 1 downto 0);
			 b : in  std_logic_vector(BREITE - 1 downto 0);
			 q : out std_logic_vector(BREITE * 2 - 1 downto 0));
	end component gen_multi;

	component gen_register
		generic(BREITE : positive := 8);
		port(clk : in  std_logic;
			 rst : in  std_logic;
			 we  : in  std_logic;
			 a   : in  std_logic_vector(BREITE - 1 downto 0);
			 q   : out std_logic_vector(BREITE - 1 downto 0));
	end component gen_register;

	signal current_state : natural range 0 to 5 := 0;
	signal next_state    : natural range 0 to 5 := 0;

	signal op1_plus1 : std_logic_vector(BREITE - 1 downto 0);
	signal op2_plus1 : std_logic_vector(BREITE - 1 downto 0);
	signal erg_plus1 : std_logic_vector(BREITE - 1 downto 0);

	signal op1_plus2 : std_logic_vector(BREITE - 1 downto 0);
	signal op2_plus2 : std_logic_vector(BREITE - 1 downto 0);
	signal erg_plus2 : std_logic_vector(BREITE - 1 downto 0);

	signal op1_plus3 : std_logic_vector(BREITE - 1 downto 0);
	signal op2_plus3 : std_logic_vector(BREITE - 1 downto 0);
	signal erg_plus3 : std_logic_vector(BREITE - 1 downto 0);

	signal op1_mal : std_logic_vector(BREITE - 1 downto 0);
	signal op2_mal : std_logic_vector(BREITE - 1 downto 0);
	signal erg_mal : std_logic_vector(BREITE * 2 - 1 downto 0);

	signal op1_minus : std_logic_vector(BREITE - 1 downto 0);
	signal op2_minus : std_logic_vector(BREITE - 1 downto 0);
	signal erg_minus : std_logic_vector(BREITE - 1 downto 0);

	signal a_logic : std_logic_vector(BREITE - 1 downto 0);
	signal b_logic : std_logic_vector(BREITE - 1 downto 0);
	signal c_logic : std_logic_vector(BREITE - 1 downto 0);
	signal d_logic : std_logic_vector(BREITE - 1 downto 0);
	signal e_logic : std_logic_vector(BREITE - 1 downto 0);
	signal z_logic : std_logic_vector(BREITE - 1 downto 0);
	signal y_logic : std_logic_vector(BREITE - 1 downto 0);

	constant ADD1_MUX_INPUTS : natural := 2;
	signal input_arr_add1    : std_logic_vector(ADD1_MUX_INPUTS * BREITE - 1 downto 0);
	signal s_add1            : std_logic_vector(integer(floor(log2(real(ADD1_MUX_INPUTS)) + 0.5)) - 1 downto 0);
	signal q_add1            : std_logic_vector(BREITE - 1 downto 0);

	constant ADD2_MUX_INPUTS : natural := 2;
	signal input_arr_add2    : std_logic_vector(ADD2_MUX_INPUTS * BREITE - 1 downto 0);
	signal s_add2            : std_logic_vector(integer(floor(log2(real(ADD2_MUX_INPUTS)) + 0.5)) - 1 downto 0);
	signal q_add2            : std_logic_vector(BREITE - 1 downto 0);

	constant ADD3_MUX_INPUTS : natural := 2;
	signal input_arr_add3    : std_logic_vector(ADD3_MUX_INPUTS * BREITE - 1 downto 0);
	signal s_add3            : std_logic_vector(integer(floor(log2(real(ADD3_MUX_INPUTS)) + 0.5)) - 1 downto 0);
	signal q_add3            : std_logic_vector(BREITE - 1 downto 0);

	constant MULTI_MUX_INPUTS : natural := 3;
	signal input_arr_multi    : std_logic_vector(MULTI_MUX_INPUTS * BREITE - 1 downto 0);
	signal s_multi            : std_logic_vector(integer(floor(log2(real(MULTI_MUX_INPUTS)) + 0.5)) - 1 downto 0);
	signal q_multi            : std_logic_vector(BREITE - 1 downto 0);

	constant SUB_MUX_INPUTS : natural := 1;
	signal input_arr_sub    : std_logic_vector(SUB_MUX_INPUTS * BREITE - 1 downto 0);
	signal s_sub            : std_logic_vector(integer(floor(log2(real(SUB_MUX_INPUTS)) + 0.5)) - 1 downto 0);
	signal q_sub            : std_logic_vector(BREITE - 1 downto 0);

	signal we_v1v10 : std_logic;
	signal we_v1v7  : std_logic;
	signal we_v2v5  : std_logic;
	signal we_v3v5  : std_logic;
	signal we_v4v6  : std_logic;
	signal we_v6v8  : std_logic;
	signal we_v5v7  : std_logic;
	signal we_v7v9  : std_logic;
	signal we_v9v10 : std_logic;

	signal a_v1v10 : std_logic_vector(BREITE - 1 downto 0);
	signal a_v1v7  : std_logic_vector(BREITE - 1 downto 0);
	signal a_v2v5  : std_logic_vector(BREITE - 1 downto 0);
	signal a_v3v5  : std_logic_vector(BREITE - 1 downto 0);
	signal a_v4v6  : std_logic_vector(BREITE - 1 downto 0);
	signal a_v6v8  : std_logic_vector(BREITE - 1 downto 0);
	signal a_v5v7  : std_logic_vector(BREITE - 1 downto 0);
	signal a_v7v9  : std_logic_vector(BREITE - 1 downto 0);
	signal a_v9v10 : std_logic_vector(BREITE - 1 downto 0);

	signal q_v1v10 : std_logic_vector(BREITE - 1 downto 0);
	signal q_v1v7  : std_logic_vector(BREITE - 1 downto 0);
	signal q_v2v5  : std_logic_vector(BREITE - 1 downto 0);
	signal q_v3v5  : std_logic_vector(BREITE - 1 downto 0);
	signal q_v4v6  : std_logic_vector(BREITE - 1 downto 0);
	signal q_v6v8  : std_logic_vector(BREITE - 1 downto 0);
	signal q_v5v7  : std_logic_vector(BREITE - 1 downto 0);
	signal q_v7v9  : std_logic_vector(BREITE - 1 downto 0);
	signal q_v9v10 : std_logic_vector(BREITE - 1 downto 0);

begin
	
	-- concurrent statements
	a_logic <= std_logic_vector(to_unsigned(a, BREITE));
	b_logic <= std_logic_vector(to_unsigned(b, BREITE));
	c_logic <= std_logic_vector(to_unsigned(c, BREITE));
	d_logic <= std_logic_vector(to_unsigned(d, BREITE));
	e_logic <= std_logic_vector(to_unsigned(e, BREITE));
	z       <= to_integer(unsigned(z_logic));
	y       <= to_integer(unsigned(y_logic));

	addierer_1 : gen_addition
		generic map(
			BREITE => BREITE
		)
		port map(
			a => op1_plus1,
			b => op2_plus1,
			q => erg_plus1
		);

	addierer_2 : gen_addition
		generic map(
			BREITE => BREITE
		)
		port map(
			a => op1_plus2,
			b => op2_plus2,
			q => erg_plus2
		);

	addierer_3 : gen_addition
		generic map(
			BREITE => BREITE
		)
		port map(
			a => op1_plus3,
			b => op2_plus3,
			q => erg_plus3
		);

	multiplizierer : gen_multi
		generic map(
			BREITE => BREITE
		)
		port map(
			a => op1_mal,
			b => op2_mal,
			q => erg_mal
		);

	subtrahierer : gen_sub
		generic map(
			BREITE => BREITE
		)
		port map(
			a => op1_minus,
			b => op2_minus,
			q => erg_minus
		);

	mux_add_1 : gen_mux
		generic map(
			INPUTS => ADD1_MUX_INPUTS,
			WIDTH  => BREITE
		)
		port map(
			input_arr => input_arr_add1,
			s         => s_add1,
			q         => q_add1
		);

	mux_add_2 : gen_mux
		generic map(
			INPUTS => ADD2_MUX_INPUTS,
			WIDTH  => BREITE
		)
		port map(
			input_arr => input_arr_add2,
			s         => s_add2,
			q         => q_add2
		);

	mux_add_3 : gen_mux
		generic map(
			INPUTS => ADD3_MUX_INPUTS,
			WIDTH  => BREITE
		)
		port map(
			input_arr => input_arr_add3,
			s         => s_add3,
			q         => q_add3
		);

	mux_multi : gen_mux
		generic map(
			INPUTS => MULTI_MUX_INPUTS,
			WIDTH  => BREITE
		)
		port map(
			input_arr => input_arr_multi,
			s         => s_multi,
			q         => q_multi
		);

	mux_sub : gen_mux
		generic map(
			INPUTS => SUB_MUX_INPUTS,
			WIDTH  => BREITE
		)
		port map(
			input_arr => input_arr_sub,
			s         => s_sub,
			q         => q_sub
		);

	v1v10 : gen_register
		generic map(
			BREITE => BREITE
		)
		port map(
			clk => clk,
			rst => rst,
			we  => we_v1v10,
			a   => a_v1v10,
			q   => q_v1v10
		);

	v1v7 : gen_register
		generic map(
			BREITE => BREITE
		)
		port map(
			clk => clk,
			rst => rst,
			we  => we_v1v7,
			a   => a_v1v7,
			q   => q_v1v7
		);

	v2v5 : gen_register
		generic map(
			BREITE => BREITE
		)
		port map(
			clk => clk,
			rst => rst,
			we  => we_v2v5,
			a   => a_v2v5,
			q   => q_v2v5
		);

	v3v5 : gen_register
		generic map(
			BREITE => BREITE
		)
		port map(
			clk => clk,
			rst => rst,
			we  => we_v3v5,
			a   => a_v3v5,
			q   => q_v3v5
		);

	v4v6 : gen_register
		generic map(
			BREITE => BREITE
		)
		port map(
			clk => clk,
			rst => rst,
			we  => we_v4v6,
			a   => a_v4v6,
			q   => q_v4v6
		);

	v6v8 : gen_register
		generic map(
			BREITE => BREITE
		)
		port map(
			clk => clk,
			rst => rst,
			we  => we_v6v8,
			a   => a_v6v8,
			q   => q_v6v8
		);

	v5v7 : gen_register
		generic map(
			BREITE => BREITE
		)
		port map(
			clk => clk,
			rst => rst,
			we  => we_v5v7,
			a   => a_v5v7,
			q   => q_v5v7
		);

	v7v9 : gen_register
		generic map(
			BREITE => BREITE
		)
		port map(
			clk => clk,
			rst => rst,
			we  => we_v7v9,
			a   => a_v7v9,
			q   => q_v7v9
		);

	v9v10 : gen_register
		generic map(
			BREITE => BREITE
		)
		port map(
			clk => clk,
			rst => rst,
			we  => we_v9v10,
			a   => a_v9v10,
			q   => q_v9v10
		);

	ausgang : process(clk, rst) is
	begin
		if rst = '1' then
			null;
		elsif rising_edge(clk) then
			case next_state is
				when 0 =>
					op1_mal <= d_logic;
					op2_mal <= a_logic;
					a_v1v7  <= erg_mal(BREITE - 1 downto 0);
					we_v1v7 <= '1';

				when 1      => null;
				when 2      => null;
				when 3      => null;
				when 4      => null;
				when 5      => null;
				when others => null;
			end case;

		end if;
	end process ausgang;

	speicher : process(clk) is
	begin
		if rising_edge(clk) then
			next_state <= current_state;
		end if;
	end process speicher;

end architecture RTL;
