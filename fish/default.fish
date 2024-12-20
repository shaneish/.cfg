
fish_add_path - add to the path

ffiisshh__aadddd__ppaatthh ppaatthh ...
ffiisshh__aadddd__ppaatthh [(--gg | ----gglloobbaall) | (--UU | ----uunniivveerrssaall) | (--PP | ----ppaatthh)] [(--mm | ----mmoovvee)] [(--aa | ----aappppeenndd) | (--pp | ----pprreeppeenndd)] [(--vv | ----vveerrbboossee) | (--nn | ----ddrryy--rruunn)] _P_A_T_H_S ...

DDEESSCCRRIIPPTTIIOONN
ffiisshh__aadddd__ppaatthh  is  a simple way to add more components to fish's _P_A_T_H. It does this by adding the compo‐
nents either to $fish_user_paths or directly to _P_A_T_H (if the ----ppaatthh switch is given).

It is (by default) safe to use ffiisshh__aadddd__ppaatthh in config.fish, or it can be used once, interactively,  and
the  paths will stay in future because of _u_n_i_v_e_r_s_a_l _v_a_r_i_a_b_l_e_s. This is a "do what I mean" style command,
if you need more control, consider modifying the variable yourself.

Components are normalized by _r_e_a_l_p_a_t_h. Trailing slashes are ignored and relative paths are made absolute
(but symlinks are not resolved). If a component already exists, it is not added again and stays  in  the
same place unless the ----mmoovvee switch is given.

Components  are added in the order they are given, and they are prepended to the path unless ----aappppeenndd is
given (if $fish_user_paths is used, that means they  are  last  in  $fish_user_paths,  which  is  itself
prepended to _P_A_T_H, so they still stay ahead of the system paths).

If  no  component is new, the variable (_f_i_s_h___u_s_e_r___p_a_t_h_s or _P_A_T_H) is not set again or otherwise modified,
so variable handlers are not triggered.

If a component is not an existing directory, ffiisshh__aadddd__ppaatthh ignores it.

OOPPTTIIOONNSS
--aa or ----aappppeenndd
       Add components to the _e_n_d of the variable.

--pp or ----pprreeppeenndd
       Add components to the _f_r_o_n_t of the variable (this is the default).

--gg or ----gglloobbaall
       Use a global _f_i_s_h___u_s_e_r___p_a_t_h_s.

--UU or ----uunniivveerrssaall
       Use a universal _f_i_s_h___u_s_e_r___p_a_t_h_s - this is the default if it doesn't already exist.

--PP or ----ppaatthh
       Manipulate _P_A_T_H directly.

--mm or ----mmoovvee
       Move already-existing components to the place they would be added - by default they would be left
       in place and not added again.

--vv or ----vveerrbboossee
       Print the _s_e_t command used.

--nn or ----ddrryy--rruunn
       Print the sseett command that would be used without executing it.

--hh or ----hheellpp
       Displays help about using this command.

If ----mmoovvee is used, it may of course lead to the path swapping order, so you should be careful doing that
in config.fish.

EEXXAAMMPPLLEE
   # I just installed mycoolthing and need to add it to the path to use it.
   > fish_add_path /opt/mycoolthing/bin

   # I want my ~/.local/bin to be checked first.
   > fish_add_path -m ~/.local/bin

   # I prefer using a global fish_user_paths
   > fish_add_path -g ~/.local/bin ~/.otherbin /usr/local/sbin

   # I want to append to the entire $PATH because this directory contains fallbacks
   > fish_add_path -aP /opt/fallback/bin

   # I want to add the bin/ directory of my current $PWD (say /home/nemo/)
   > fish_add_path -v bin/
   set fish_user_paths /home/nemo/bin /usr/bin /home/nemo/.local/bin

   # I have installed ruby via homebrew
   > fish_add_path /usr/local/opt/ruby/bin
