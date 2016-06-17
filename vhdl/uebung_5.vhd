library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity uebung_5 is
	port(
		clk              : in  std_logic;
		rst              : in  std_logic;
		a, b, c, d, e, x : in  integer;
		y, z             : out integer;
		ready            : out boolean
	);
end entity uebung_5;

architecture RTL of uebung_5 is
	constant BREITE : natural := 32;
	constant INPUTS : natural := 2;

	type ZUSTAENDE is (takt1, takt2, takt3, takt4, takt5, takt6);

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

	signal current_state : ZUSTAENDE := takt1;
	signal next_state    : ZUSTAENDE := takt1;

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
	signal x_logic : std_logic_vector(BREITE - 1 downto 0);
	signal z_logic : std_logic_vector(BREITE - 1 downto 0);
	signal y_logic : std_logic_vector(BREITE - 1 downto 0);

	constant ADD1_MUX_INPUTS  : natural := 2;
	signal input_arr_add1_op1 : std_logic_vector(ADD1_MUX_INPUTS * BREITE - 1 downto 0);
	signal s_add1_op1         : std_logic_vector(integer(floor(log2(real(ADD1_MUX_INPUTS)) + 0.5)) - 1 downto 0);
	signal q_add1_op1         : std_logic_vector(BREITE - 1 downto 0);

	signal input_arr_add1_op2 : std_logic_vector(ADD1_MUX_INPUTS * BREITE - 1 downto 0);
	signal s_add1_op2         : std_logic_vector(integer(floor(log2(real(ADD1_MUX_INPUTS)) + 0.5)) - 1 downto 0);
	signal q_add1_op2         : std_logic_vector(BREITE - 1 downto 0);

	constant ADD2_MUX_INPUTS  : natural := 2;
	signal input_arr_add2_op1 : std_logic_vector(ADD2_MUX_INPUTS * BREITE - 1 downto 0);
	signal s_add2_op1         : std_logic_vector(integer(floor(log2(real(ADD2_MUX_INPUTS)) + 0.5)) - 1 downto 0);
	signal q_add2_op1         : std_logic_vector(BREITE - 1 downto 0);

	signal input_arr_add2_op2 : std_logic_vector(ADD2_MUX_INPUTS * BREITE - 1 downto 0);
	signal s_add2_op2         : std_logic_vector(integer(floor(log2(real(ADD2_MUX_INPUTS)) + 0.5)) - 1 downto 0);
	signal q_add2_op2         : std_logic_vector(BREITE - 1 downto 0);

	constant ADD3_MUX_INPUTS  : natural := 2;
	signal input_arr_add3_op1 : std_logic_vector(ADD3_MUX_INPUTS * BREITE - 1 downto 0);
	signal s_add3_op1         : std_logic_vector(integer(floor(log2(real(ADD3_MUX_INPUTS)) + 0.5)) - 1 downto 0);
	signal q_add3_op1         : std_logic_vector(BREITE - 1 downto 0);

	signal input_arr_add3_op2 : std_logic_vector(ADD3_MUX_INPUTS * BREITE - 1 downto 0);
	signal s_add3_op2         : std_logic_vector(integer(floor(log2(real(ADD3_MUX_INPUTS)) + 0.5)) - 1 downto 0);
	signal q_add3_op2         : std_logic_vector(BREITE - 1 downto 0);

	constant MULTI_MUX_INPUTS  : natural := 3;
	signal input_arr_multi_op1 : std_logic_vector(MULTI_MUX_INPUTS * BREITE - 1 downto 0);
	signal s_multi_op1         : std_logic_vector(integer(floor(log2(real(MULTI_MUX_INPUTS)) + 0.5)) - 1 downto 0);
	signal q_multi_op1         : std_logic_vector(BREITE - 1 downto 0);

	signal input_arr_multi_op2 : std_logic_vector(MULTI_MUX_INPUTS * BREITE - 1 downto 0);
	signal s_multi_op2         : std_logic_vector(integer(floor(log2(real(MULTI_MUX_INPUTS)) + 0.5)) - 1 downto 0);
	signal q_multi_op2         : std_logic_vector(BREITE - 1 downto 0);

	constant SUB_MUX_INPUTS  : natural := 2;
	signal input_arr_sub_op1 : std_logic_vector(SUB_MUX_INPUTS * BREITE - 1 downto 0);
	signal s_sub_op1         : std_logic_vector(integer(floor(log2(real(SUB_MUX_INPUTS)) + 0.5)) - 1 downto 0);
	signal q_sub_op1         : std_logic_vector(BREITE - 1 downto 0);

	signal input_arr_sub_op2 : std_logic_vector(SUB_MUX_INPUTS * BREITE - 1 downto 0);
	signal s_sub_op2         : std_logic_vector(integer(floor(log2(real(SUB_MUX_INPUTS)) + 0.5)) - 1 downto 0);
	signal q_sub_op2         : std_logic_vector(BREITE - 1 downto 0);

	signal s_sub_21 : std_logic_vector(BREITE - 1 downto 0) := (others => '0');
	signal s_sub_22 : std_logic_vector(BREITE - 1 downto 0) := (others => '0');

	signal we_v1v10     : std_logic;
	signal we_v1v7      : std_logic;
	signal we_v2v5      : std_logic;
	signal we_v3v5      : std_logic;
	signal we_v4v6      : std_logic;
	signal we_v6v8      : std_logic;
	signal we_v5v7      : std_logic;
	signal we_v7v9      : std_logic;
	signal we_v9v10     : std_logic;
	signal we_y_ausgang : std_logic;
	signal we_z_ausgang : std_logic;

	signal a_v1v10     : std_logic_vector(BREITE - 1 downto 0);
	signal a_v1v7      : std_logic_vector(BREITE - 1 downto 0);
	signal a_v2v5      : std_logic_vector(BREITE - 1 downto 0);
	signal a_v3v5      : std_logic_vector(BREITE - 1 downto 0);
	signal a_v4v6      : std_logic_vector(BREITE - 1 downto 0);
	signal a_v6v8      : std_logic_vector(BREITE - 1 downto 0);
	signal a_v5v7      : std_logic_vector(BREITE - 1 downto 0);
	signal a_v7v9      : std_logic_vector(BREITE - 1 downto 0);
	signal a_v9v10     : std_logic_vector(BREITE - 1 downto 0);
	signal a_y_ausgang : std_logic_vector(BREITE - 1 downto 0);
	signal a_z_ausgang : std_logic_vector(BREITE - 1 downto 0);

	signal q_v1v10     : std_logic_vector(BREITE - 1 downto 0);
	signal q_v1v7      : std_logic_vector(BREITE - 1 downto 0);
	signal q_v2v5      : std_logic_vector(BREITE - 1 downto 0);
	signal q_v3v5      : std_logic_vector(BREITE - 1 downto 0);
	signal q_v4v6      : std_logic_vector(BREITE - 1 downto 0);
	signal q_v6v8      : std_logic_vector(BREITE - 1 downto 0);
	signal q_v5v7      : std_logic_vector(BREITE - 1 downto 0);
	signal q_v7v9      : std_logic_vector(BREITE - 1 downto 0);
	signal q_v9v10     : std_logic_vector(BREITE - 1 downto 0);
	signal q_y_ausgang : std_logic_vector(BREITE - 1 downto 0);
	signal q_z_ausgang : std_logic_vector(BREITE - 1 downto 0);

	signal s_all_without_multi : std_logic_vector(0 downto 0) := "0";
	signal s_multi             : std_logic_vector(1 downto 0) := "00";

begin

	-- concurrent statements
	a_logic <= std_logic_vector(to_unsigned(a, BREITE));
	b_logic <= std_logic_vector(to_unsigned(b, BREITE));
	c_logic <= std_logic_vector(to_unsigned(c, BREITE));
	d_logic <= std_logic_vector(to_unsigned(d, BREITE));
	e_logic <= std_logic_vector(to_unsigned(e, BREITE));
	x_logic <= std_logic_vector(to_unsigned(x, BREITE));
	z       <= to_integer(unsigned(z_logic));
	y       <= to_integer(unsigned(y_logic));

	-- multiplexer statments
	---------------------------------------------
	-- declaring the inputs of all operatos with the muxs'
	op1_plus1 <= q_add1_op1;
	op2_plus1 <= q_add1_op2;

	op1_plus2 <= q_add2_op1;
	op2_plus2 <= q_add2_op2;

	op1_plus3 <= q_add3_op1;
	op2_plus3 <= q_add3_op2;

	op1_mal <= q_multi_op1;
	op2_mal <= q_multi_op2;

	op1_minus <= q_sub_op1;
	op2_minus <= q_sub_op2;

	-------------------------------------------------------
	-- register settings
	a_v1v7  <= std_logic_vector(resize(unsigned(erg_mal), BREITE));
	a_v9v10 <= std_logic_vector(resize(unsigned(erg_mal), BREITE));
	a_v6v8  <= std_logic_vector(resize(unsigned(erg_mal), BREITE));
	a_v1v10 <= std_logic_vector(resize(unsigned(erg_mal), BREITE)); -- doppelt gemoppelt, könnte auch anders ausfallsen

	a_v2v5 <= erg_plus1;
	a_v5v7 <= erg_plus1;

	a_v3v5 <= erg_plus2;
	a_v7v9 <= erg_plus2;

	a_v4v6 <= erg_plus3;

	-- erg settings
	z_logic     <= q_z_ausgang;
	y_logic     <= q_y_ausgang;
	a_y_ausgang <= erg_minus;
	a_z_ausgang <= erg_plus3;

	-- multiplexer settings
	input_arr_add1_op1 <= q_v2v5 & a_logic;
	input_arr_add1_op2 <= q_v3v5 & x_logic;

	input_arr_add2_op1 <= q_v5v7 & d_logic;
	input_arr_add2_op2 <= q_v1v7 & c_logic;

	input_arr_add3_op1 <= q_v1v10 & b_logic;
	input_arr_add3_op2 <= q_v9v10 & c_logic;

	input_arr_multi_op1 <= q_v7v9 & q_v4v6 & a_logic;
	input_arr_multi_op2 <= e_logic & a_logic & d_logic;

	input_arr_sub_op1 <= x_logic & s_sub_21;
	input_arr_sub_op2 <= q_v6v8 & s_sub_22;

	-- trick 
	s_add1_op1 <= s_all_without_multi;
	s_add1_op2 <= s_all_without_multi;
	s_add2_op1 <= s_all_without_multi;
	s_add2_op2 <= s_all_without_multi;
	s_add3_op1 <= s_all_without_multi;
	s_add3_op2 <= s_all_without_multi;
	s_sub_op1  <= s_all_without_multi;
	s_sub_op2  <= s_all_without_multi;

	s_multi_op1 <= s_multi;
	s_multi_op2 <= s_multi;

	addierer_1 : gen_addition
		generic map(
			BREITE => BREITE
		) port map(
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

	mux_add_1_op1 : gen_mux
		generic map(
			INPUTS => ADD1_MUX_INPUTS,
			WIDTH  => BREITE
		)
		port map(
			input_arr => input_arr_add1_op1,
			s         => s_add1_op1,
			q         => q_add1_op1
		);

	mux_add_1_op2 : gen_mux
		generic map(
			INPUTS => ADD1_MUX_INPUTS,
			WIDTH  => BREITE
		)
		port map(
			input_arr => input_arr_add1_op2,
			s         => s_add1_op2,
			q         => q_add1_op2
		);

	mux_add_2_op1 : gen_mux
		generic map(
			INPUTS => ADD2_MUX_INPUTS,
			WIDTH  => BREITE
		)
		port map(
			input_arr => input_arr_add2_op1,
			s         => s_add2_op1,
			q         => q_add2_op1
		);

	mux_add_2_op2 : gen_mux
		generic map(
			INPUTS => ADD2_MUX_INPUTS,
			WIDTH  => BREITE
		)
		port map(
			input_arr => input_arr_add2_op2,
			s         => s_add2_op2,
			q         => q_add2_op2
		);

	mux_add_3_op1 : gen_mux
		generic map(
			INPUTS => ADD3_MUX_INPUTS,
			WIDTH  => BREITE
		)
		port map(
			input_arr => input_arr_add3_op1,
			s         => s_add3_op1,
			q         => q_add3_op1
		);

	mux_add_3_op2 : gen_mux
		generic map(
			INPUTS => ADD3_MUX_INPUTS,
			WIDTH  => BREITE
		)
		port map(
			input_arr => input_arr_add3_op2,
			s         => s_add3_op2,
			q         => q_add3_op2
		);

	mux_multi_op1 : gen_mux
		generic map(
			INPUTS => MULTI_MUX_INPUTS,
			WIDTH  => BREITE
		)
		port map(
			input_arr => input_arr_multi_op1,
			s         => s_multi_op1,
			q         => q_multi_op1
		);

	mux_multi_op2 : gen_mux
		generic map(
			INPUTS => MULTI_MUX_INPUTS,
			WIDTH  => BREITE
		)
		port map(
			input_arr => input_arr_multi_op2,
			s         => s_multi_op2,
			q         => q_multi_op2
		);

	mux_sub_op1 : gen_mux
		generic map(
			INPUTS => SUB_MUX_INPUTS,
			WIDTH  => BREITE
		)
		port map(
			input_arr => input_arr_sub_op1,
			s         => s_sub_op1,
			q         => q_sub_op1
		);

	mux_sub_op2 : gen_mux
		generic map(
			INPUTS => SUB_MUX_INPUTS,
			WIDTH  => BREITE
		)
		port map(
			input_arr => input_arr_sub_op2,
			s         => s_sub_op2,
			q         => q_sub_op2
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

	y_ausgangs_reg : gen_register
		generic map(
			BREITE => BREITE
		)
		port map(
			clk => clk,
			rst => rst,
			we  => we_y_ausgang,
			a   => a_y_ausgang,
			q   => q_y_ausgang
		);

	z_ausgang_reg : gen_register
		generic map(
			BREITE => BREITE
		)
		port map(
			clk => clk,
			rst => rst,
			we  => we_z_ausgang,
			a   => a_z_ausgang,
			q   => q_z_ausgang
		);

	uerbergangs_netzwerk : process(current_state) is
	begin
		s_all_without_multi <= "0";
		s_multi             <= "00";
		we_v2v5             <= '0';
		we_v1v10            <= '0';
		we_v1v7             <= '0';
		we_v3v5             <= '0';
		we_v4v6             <= '0';
		we_v5v7             <= '0';
		we_v6v8             <= '0';
		we_v7v9             <= '0';
		we_v6v8             <= '0';
		we_v9v10            <= '0';
		we_y_ausgang        <= '0';
		we_z_ausgang        <= '0';
		next_state          <= takt1;
		ready               <= false;
		case current_state is
			when takt1 =>
				s_all_without_multi <= "0";
				s_multi             <= "00";
				we_v2v5             <= '1';
				we_v1v10            <= '1';
				we_v1v7             <= '1';
				we_v3v5             <= '1';
				we_v4v6             <= '1';
				next_state          <= takt2;
			when takt2 =>
				s_all_without_multi <= "1";
				s_multi             <= "01";
				we_v5v7             <= '1';
				we_v6v8             <= '1';
				next_state          <= takt3;
			when takt3 =>
				s_all_without_multi <= "1";
				we_v7v9             <= '1';
				we_y_ausgang        <= '1';
				next_state          <= takt4;
			when takt4 =>
				s_multi    <= "10";
				we_v9v10   <= '1';
				next_state <= takt5;
			when takt5 =>
				s_all_without_multi <= "1";
				we_z_ausgang        <= '1';
				next_state          <= takt6;
			when takt6 =>
				ready <= true;
			when others => null;
		end case;
	end process uerbergangs_netzwerk;

	zustands_speicher : process(clk, rst) is
	begin
		if rst = '1' then
			current_state <= takt1;
		end if;
		if rising_edge(clk) then
			current_state <= next_state;
		end if;
	end process zustands_speicher;

end architecture RTL;
