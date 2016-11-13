cat <<EOF >> $HOME/.ssh/config
Host sakura
    HostName       $IP
    IdentityFile   ~/.ssh/id_$IP
    User           id_$USER
    Port           $PORT
EOF
