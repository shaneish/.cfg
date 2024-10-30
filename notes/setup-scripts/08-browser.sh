# browser
dnf config-manager --set-enabled google-chrome -y

dnf install -y google-chrome-stable
# _empa BROWSER $(which google-chrome-stable)

dnf copr enable sneexy/zen-browser
dnf install zen-browser
_empa BROWSER $(which zen-browser)