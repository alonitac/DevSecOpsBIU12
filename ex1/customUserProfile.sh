# your solution here...
echo Hello $USER
/usr/lib/update-notifier/apt-check --human-readable
if [ -a ~/.token ]; then
if [ $(stat -c %a ~/.token) != 600 ]; then
echo "Warning: .token file has too wide permissions"
fi
else
touch ~/.token
chmod 600 ~/.token;
echo ".token file created with permissions 600"
fi
export COURSE_ID=devsecops12
chsh -s /bin/zsh #makes zsh default shell in the next logon
zsh #switched immediately to zsh shell

