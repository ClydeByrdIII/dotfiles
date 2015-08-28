# -------------------------------------------------------------------
# When you start an interactive shell (log in, open terminal or iTerm in OS X, 
# or create a new tab in iTerm) the following files are read and run, in this order:
#     profile
#     bashrc
#     .bash_profile
#     .bashrc (only because this file is run (sourced) in .bash_profile)
#
# When an interactive shell, that is not a login shell, is started 
# (when you run "bash" from inside a shell, or when you start a shell in 
# xwindows [xterm/gnome-terminal/etc] ) the following files are read and executed, 
# in this order:
#     bashrc
#     .bashrc

# avoid problems with scp -- don't process the rest of the file if non-interactive
[[ $- != *i* ]] && return

if [ -f ~/.bashrc ]; then
    # this file is (normally) processed on each interactive invocation of bash,
    # but OS X invokes a Login Shell every new window so it is never called.
    # therefore call it upon every shell login in too, or just not have it.
    source ~/.bashrc
fi

# Hello Messsage --------------------------------------------------
echo -e "Kernel Information: " `uname -smr`
echo -e "${COLOR_BROWN}`bash --version`"
echo -ne "${COLOR_GRAY}Uptime: "; uptime
echo -ne "${COLOR_GRAY}Server time is: "; date


