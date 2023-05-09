# UshOS Install Script
echo "Installing UshOS..."
curl -s --compressed "https://lrdsnow.github.io/lrdsnows-repo/key.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/my_ppa.gpg >/dev/null
sudo curl -s --compressed -o /etc/apt/sources.list.d/lrdsnowsrepo.list "https://lrdsnow.github.io/lrdsnows-repo/lrdsnowsrepo.list"
sudo apt update
sudo apt install -y starlight ushosicons wget
wget "https://lrdsnow.github.io/ushos/wallpaper/wallpaper.png" -O ~/Pictures/ushos_wallpaper.png
if ! command -v "cinnamon" &> /dev/null; then
    read -r -p "Install Cinnamon Desktop? [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            sudo apt install -y cinnamon
            ;;
        *)
            echo Exiting...
            exit 1
            ;;
    esac
fi
gsettings set org.cinnamon.desktop.background picture-uri  "file://$HOME/Pictures/ushos_wallpaper.png"
gsettings set org.cinnamon.theme name 'starlight'
gsettings set org.cinnamon.desktop.interface icon-theme 'ushosicons'
gsettings set org.cinnamon.desktop.wm.preferences theme 'starlight'
read -r -p "Install iOS Tools? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        sudo apt install -y libimobiledevice-dev
        mkdir ~/tmp
        wget https://github.com/palera1n/palera1n/releases/download/v2.0.0-beta.5/palera1n-linux-x86_64 -O ~/tmp/palera1n
        sudo mv ~/tmp/palera1n /usr/bin/palera1n
        sudo chmod +x /usr/bin/palera1n
        wget https://assets.checkra.in/downloads/linux/cli/x86_64/dac9968939ea6e6bfbdedeb41d7e2579c4711dc2c5083f91dced66ca397dc51d/checkra1n -O ~/tmp/checkra1n
        sudo mv ~/tmp/checkra1n /usr/bin/checkra1n
        sudo chmod +x /usr/bin/checkra1n
        rm -rf ~/tmp
        echo "Installed palera1n, checkra1n and libimobiledevice"
        ;;
    *)
        echo Not installing iOS tools...
        ;;
esac
read -r -p "Install Devtools? (vscode, build-essential, etc.) [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        mkdir ~/tmp
        wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O ~/tmp/vscode.deb
        sudo apt install -y ~/tmp/vscode.deb build-essential python3 python3-pip
        rm -rf ~/tmp
        echo "Installed vscode, build-essentail, python3, python3-pip"
        ;;
    *)
        echo Not installing devtools...
        ;;
esac
read -r -p "Rewrite Release Info? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        mkdir ~/tmp
        wget "https://lrdsnow.github.io/ushos/src/update-release" -O ~/tmp/update
        sudo sh ~/tmp/update
        wget "https://raw.githubusercontent.com/Lrdsnow/lmt/main/lmt.sh" -O ~/tmp/lmt
        sudo mv ~/tmp/lmt /usr/bin/lmt
        sudo chmod +x /usr/bin/lmt
        rm -rf ~/tmp
    ;;
    *)
        echo "Not Rewriting Release Info..."
    ;;
esac
echo "Succsessfully Installed UshOS"
