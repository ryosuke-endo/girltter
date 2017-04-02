cat <<EOF >> $HOME/.ssh/config
Host girltter
    HostName       $IP
    IdentityFile   ~/.ssh/id_$IP
    User           id_$USER
    Port           $PORT
EOF
