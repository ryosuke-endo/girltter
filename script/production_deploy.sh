cd .ssh/
sed -i -e "14i User $USER" config
sed -i -e "15i Port $PORT" config
