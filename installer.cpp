#include <iostream>
#include <cstdlib>

// UshOS Install Script But C++ Bcuz its fire 🔥🔥🔥

void ushos_theme() {
    std::cout << "Installing UshOS Themes...\n";
    system("curl -s --compressed \"https://lrdsnow.github.io/lrdsnows-repo/key.gpg\" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/my_ppa.gpg >/dev/null");
    system("sudo curl -s --compressed -o /etc/apt/sources.list.d/lrdsnowsrepo.list \"https://lrdsnow.github.io/lrdsnows-repo/lrdsnowsrepo.list\"");
    system("sudo apt update");
    system("sudo apt install -y starlight ushosicons wget");
    system("wget \"https://lrdsnow.github.io/ushos/wallpaper/wallpaper.png\" -O ~/Pictures/ushos_wallpaper.png");
    if (system("command -v \"cinnamon\" &> /dev/null") != 0) {
        std::string response;
        std::cout << "Install Cinnamon Desktop? [y/N] ";
        std::cin >> response;
        if (response == "y" || response == "Y") {
            system("sudo apt install -y cinnamon");
        } else {
            std::cout << "Exiting..." << std::endl;
            exit(1);
        }
    }
    system("gsettings set org.cinnamon.desktop.background picture-uri  \"file://$HOME/Pictures/ushos_wallpaper.png\"");
    system("gsettings set org.cinnamon.theme name 'starlight'");
    system("gsettings set org.cinnamon.desktop.interface icon-theme 'ushosicons'");
    system("gsettings set org.cinnamon.desktop.wm.preferences theme 'starlight'");
}

void ios_tools() {
    std::cout << "Installing iOS Jailbreak Tools...\n";
    system("sudo apt install -y libimobiledevice-dev");
    system("mkdir ~/tmp");
    system("wget https://github.com/palera1n/palera1n/releases/download/v2.0.0-beta.5/palera1n-linux-x86_64 -O ~/tmp/palera1n");
    system("sudo mv ~/tmp/palera1n /usr/bin/palera1n");
    system("sudo chmod +x /usr/bin/palera1n");
    system("wget https://assets.checkra.in/downloads/linux/cli/x86_64/dac9968939ea6e6bfbdedeb41d7e2579c4711dc2c5083f91dced66ca397dc51d/checkra1n -O ~/tmp/checkra1n");
    system("sudo mv ~/tmp/checkra1n /usr/bin/checkra1n");
    system("sudo chmod +x /usr/bin/checkra1n");
    system("rm -rf ~/tmp");
    std::cout << "Installed palera1n, checkra1n, and libimobiledevice" << std::endl;
}

void devtools() {
    std::cout << "Installing Common Developer Tools...\n";
    system("mkdir ~/tmp");
    system("wget \"https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64\" -O ~/tmp/vscode.deb");
    system("sudo apt install -y ~/tmp/vscode.deb build-essential python3 python3-pip");
    system("rm -rf ~/tmp");
    std::cout << "Installed vscode, build-essential, python3, python3-pip" << std::endl;
}

void rinfo() {
    std::cout << "Changing Release Info to UshOS's Release Info...\n";
    system("mkdir ~/tmp");
    system("wget \"https://lrdsnow.github.io/ushos/src/update-release\" -O ~/tmp/update");
    system("sudo sh ~/tmp/update");
    system("wget \"https://raw.githubusercontent.com/Lrdsnow/lmt/main/lmt.sh\" -O ~/tmp/lmt");
    system("sudo mv ~/tmp/lmt /usr/bin/lmt");
    system("sudo chmod +x /usr/bin/lmt");
    system("rm -rf ~/tmp");
}

int main(int argc, char** argv) {
    std::cout << " ____ ___      .__     ________    _________" << std::endl;
    std::cout << "|    |   \\_____|  |__  \\_____  \\  /   _____/" << std::endl;
    std::cout << "|    |   /  ___/  |  \\  /   |   \\ \\_____  \\" << std::endl;
    std::cout << "|    |  /\\___ \\|   Y  \\/    |    \\/        \\" << std::endl;
    std::cout << "|______//____  >___|  /\\_______  /_______  /" << std::endl;
    std::cout << "             \\/     \\/         \\/        \\/" << std::endl;
    if (argc > 2 && std::string(argv[1]) == "install" && std::string(argv[2]) == "all") {
        ushos_theme();
        ios_tools();
        devtools();
        if (argc > 2 && std::string(argv[3]) == "unsafe") {
            rinfo();
        }
    } else if (argc > 1 && std::string(argv[1]) == "install") {
        std::string response;
        std::cout << "Install UshOS Themes? [y/N] ";
        std::cin >> response;
        if (response == "y" || response == "Y") {
            ushos_theme();
        } else {
            std::cout << "Not installing the UshOS theme..." << std::endl;
        }

        std::cout << "Install iOS Tools? [y/N] ";
        std::cin >> response;
        if (response == "y" || response == "Y") {
            ios_tools();
        } else {
            std::cout << "Not installing iOS tools..." << std::endl;
        }

        std::cout << "Install Devtools? (vscode, build-essential, etc.) [y/N] ";
        std::cin >> response;
        if (response == "y" || response == "Y") {
            devtools();
        } else {
            std::cout << "Not installing devtools..." << std::endl;
        }

        std::cout << "Rewrite Release Info? (Looks cool, Breaks things) [y/N] ";
        std::cin >> response;
        if (response == "y" || response == "Y") {
            rinfo();
        } else {
            std::cout << "Not rewriting Release Info..." << std::endl;
        }

        std::cout << "Successfully Installed UshOS" << std::endl;
    } else {
        int response;

        do {
            std::cout << "\nInstall UshOS:\n\n1 - Install UshOS Themes\n2 - Install iOS Jailbreak Tools\n3 - Install Common Developer Tools\n4 - Change Release Info To UshOS\n5 - Exit\n\nSelect an option: ";
            std::cin >> response;

            switch (response) {
                case 1:
                    ushos_theme();
                    break;
                case 2:
                    ios_tools();
                    break;
                case 3:
                    devtools();
                    break;
                case 4:
                    rinfo();
                    break;
                case 5:
                    return 0;
                default:
                    std::cout << response << " not a valid option\n";
                    break;
            }
        } while (true);

        return 0;
    }

    return 0;
}
