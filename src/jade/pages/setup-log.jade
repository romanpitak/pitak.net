---
template: page
title: "Setup log"
url: "/setup.log"
---
:markdown
    # My setup log
    
    This page servers me as a log of software and setup I have done
    on my development machine. 
    I try to install as much as possible locally 
    (in $HOME and withour root)
    and keep my $PATH as short and clean as possible.
    
    ## NVM
    
    Checkout the git repo into `~/.nvm`:
    
    ```bash
    git clone https://github.com/creationix/nvm.git ~/.nvm
    ```
        
    Set to latest version
        
    ```bash
    cd ~/.nvm
    git checkout \
        "$(git describe --abbrev=0 --tags)"
    ```
        
    Install some `node`
    
    ```bash
        source ~/.nvm/nvm.sh
        nvm install 0.10
        nvm install 0.11
        nvm install 0.12
        nvm install iojs
        node --version
    ```
    
    Load `nvm` in `~/.bashrc`
    
    ```bash
    # NVM
    if test -d "${HOME}/.nvm"; then
        if test -f "${HOME}/.nvm/nvm.sh"; then
            . "${HOME}/.nvm/nvm.sh"
        fi
        if test -r "${HOME}/.nvm/bash_completion"; then
            . "${HOME}/.nvm/bash_completion"
        fi
        nvm use iojs
    fi
    ```
    
    ### npm packages
    
    ```bash
    npm install bower --global
    ```

    ## Atom

    Prepare sources

    ```bash
    git clone https://github.com/atom/atom "${HOME}/var/src/atom"
    cd "${HOME}/var/src/atom"
    git fetch --prune
    git checkout $(git describe --tags \
        $(git rev-list --tags --max-count=1))
    ```

    Build

    ```bash
    export TMPDIR="${HOME}/var/tmp/atom"
    script/build
    ```

    Install

    ```bash
    script/grunt install --install-dir "${HOME}/opt/atom"

    cd "${HOME}/bin"
    ln --symbolic ../opt/atom/bin/atom atom
    ln --symbolic ../opt/atom/bin/apm apm
    ```

    Cleanup

    ```bash
    rm --recursive --force -- \
        "${HOME}/var/src/atom"
    rm --recursive --force -- \
        "${HOME}/var/tmp/atom"
    cd
    ```

    ## RVM

    ```bash
    sudo apt-get install libreadline6-dev libyaml-dev \
        sqlite3 libgdbm-dev libncurses5-dev libffi-dev \
        --assume-yes
    gpg --keyserver hkp://keys.gnupg.net \
        --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -L https://get.rvm.io | bash -s stable --autolibs=enabled
    ```
        
    ### Further setup [optional]
    
    The `rvm` install script adds `rvm` loading lines into 
    `~/.profile` and `~/.bash_profile` by default. 
    
    ```bash
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
    
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
    ```
    
    Depending on your current init files settings,
    you may want to have a look at that. 

    ### Ruby

    ```bash
    rvm list known
    rvm install ruby
    rvm docs generate-ri # generate documentation
    ```

    ### Gems

    ```bash
    gem update --system
    gem install compass
    ```
        
    ## `meteor`
    
    Unfortunatelly `meteor` needs to install sources into `~/.meteor`.
    It provides a good install script,
    but it installs itself into PATH in `/usr/local`.
    We need to change the `PREFIX` variable to install into `~/bin`.
    
    ```bash
    curl 'https://install.meteor.com/' | \
        sed -e 's/^PREFIX=.*/PREFIX="${HOME}"/' | \
        bash
    ```
    
    **note**: It sould be possible to install it to a custom location
    using the METEOR_WAREHOUSE_DIR variable.
    Maybe it's worth a try.
    No time now.
