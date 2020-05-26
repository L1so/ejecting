# ejecting
Simple Bash Script to eject any flash drive and external drive using udisks2 `udisksctl` command. You'll need udisks2 package to execute the script

Though the script has already contain validation if the user doesn't have package udisks2, which they prompt to install.

### How to use ?
    switch: [-h|-?|--h|--help] [-i|--interactive]
    usage: ejecting [drive name]
           ejecting /dev/sdb

    Toggle --interactive switch to automate task

### Installation

To make it work on local sanction, create `~/bin` directory to store the script.

    mkdir ~/bin
    source ~/.profile
    
You can now download the script directly to the `~/bin` directory

    wget -O $HOME/bin/ejecting https://raw.githubusercontent.com/pascalbrahma/ejecting/master/eject
    chmod u+x $HOME/bin/ejecting
    
Voila ! Try `ejecting` external drive :)
