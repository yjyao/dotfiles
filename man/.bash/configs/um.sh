# um: Personal man pages.

export MANPATH="$MANPATH:$HOME/.man"

# # Uncomment the following to add the `jy` section to man.
# # I.e., use it like `man jy grep`.
# # However, this requires a clever way to get the default $MANSECT which may
# # vary from system to system. You can manually check it with
# #     $ cat /etc/man*.{config,conf} 2>/dev/null | grep "^SECTION" ||
# #         man man | grep '$MANSECT'
# DEFAULT_MANSECT="1:n:l:8:3:2:3posix:3pm:3perl:3am:5:4:9:6:7"
# export MANSECT="${MANSECT:-$DEFAULT_MANSECT}:jy"
