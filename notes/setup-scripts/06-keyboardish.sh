# keyboardish
dnf copr enable alternateved/keyd
dnf install keyd

mkdir /etc/keyd
touch /etc/keyd/default.conf
cat > /etc/keyd/default.conf <<EOL
[ids]
*

[main]
capslock = overload(control, esc)

[alt]
h = left
l = right
j = down
k = up
EOL

systemctl enable keyd && systemctl start keyd