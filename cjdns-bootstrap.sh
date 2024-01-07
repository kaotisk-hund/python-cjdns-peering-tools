#!/bin/bash
packageManagerExecutable=""
packageManagerInstallCommand=""
packageManagerDontAskFlag=""
sudoExecutable="sudo"
peeringToolsRepositoryURL="https://github.com/kaotisk-hund/python-cjdns-peering-tools"
peeringToolsArchiveURL="http://arching-kaos.net/files/nightly-archives/python-cjdns-peering-tools-nightly-latest.tar.gz"

declare -a supportedPackageManagers=("dnf" "pacman")

sudoDetection(){
    which $sudoExecutable > /dev/null 2>&1
    if [ $? -ne 0 ]
    then
        sudoExecutable=""
        if [ "`whoami`" == "root" ]
        then
            printf "WARNING: You are running this script as root!\n"
            printf "It's NOT recommended or needed.\n"
            printf "Since you don't have sudo we will just continue though.\n"
        fi
    fi
}

exitMessageUnableToFindPackageManager(){
    printf "Could not find supported package manager.\n"
    printf "Consider installing cjdns on your own:\n"
    printf "https://github.com/cjdelisle/cjdns\n"
    printf "Exiting...\n"
    exit 1
}

packageManagerDetection(){
    for pkmg in "${supportedPackageManagers[@]}"
    do
        which $pkmg > /dev/null 2>&1
        if [ $? -eq 0 ]
        then
            packageManagerExecutable="$(which $pkmg)"
        fi
    done
    if [ $packageManagerExecutable == "" ]
    then
        exitMessageUnableToFindPackageManager
    else
        printf "Found package manager: %s\n" "$packageManagerExecutable"
        if [ "`basename $packageManagerExecutable`" == "dnf" ]
        then
            packageManagerInstallCommand="install"
            packageManagerDontAskFlag="-y"
        elif [ "`basename $packageManagerExecutable`" == "pacman" ]
        then
            packageManagerInstallCommand="-S"
            packageManagerDontAskFlag="--noconfirm"
        fi
    fi
}

cjdnsInstallation(){
    which cjdroute > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        printf "You already have cjdns installed.\n"
        printf "Exiting...\n"
        # exit 1
    else
        $sudoExecutable $packageManagerExecutable \
            $packageManagerInstallCommand $packageManagerDontAskFlag \
            cjdns > /dev/null 2>&1
        if [ "`basename $packageManagerExecutable`" == "dnf" ]
        then
            $sudoExecutable $packageManagerExecutable \
                $packageManagerInstallCommand $packageManagerDontAskFlag \
                cjdns-tools > /dev/null 2>&1
        fi
        if [ $? -ne 0 ]
        then
            printf "Some error occured. Exiting...\n"
            exit 1
        fi
    fi
}

peeringToolsExtraction(){
    mkdir `basename $peeringToolsRepositoryURL`
    if [ $? -ne 0 ]
    then
        printf 'Could not create directory: %s' \
            "`basename $peeringToolsRepositoryURL`"
        exit 1
    fi
    tar -C `basename $peeringToolsRepositoryURL` \
        -xvf `basename $peeringToolsArchiveURL`
    if [ $? -ne 0 ]
    then
        printf 'Could not extract archive: %s\n' \
            "`basename $peeringToolsArchiveURL`"
        exit 1
    fi
}

peersInstallation(){
    cd `basename $peeringToolsRepositoryURL`
    if [ $? -ne 0 ]
    then
        printf 'Unable to change directory to: %s\n' \
            "`basename $peeringToolsRepositoryURL`"
        exit 1
    fi
    $sudoExecutable ./gen.sh
    if [ $? -ne 0 ]
    then
        printf 'Could not install peers.\n'
        exit 1
    fi
    printf 'Peers installed successfully.\n'
    exit 0
}

peeringToolsDownload(){
    which git > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        git clone $peeringToolsRepositoryURL
        if [ $? -ne 0 ]
        then
            printf 'Unable to clone %s\n' "$peeringToolsRepositoryURL"
            exit 1
        fi
        peersInstallation
    fi
    which wget > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        wget $peeringToolsArchiveURL
        if [ $? -ne 0 ]
        then
            printf 'Unable to download URL: %s' "$peeringToolsArchiveURL"
            exit 1
        fi
        peeringToolsExtraction
        peersInstallation
    fi
    which curl > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        curl $peeringToolsArchiveURL -o "`basename $peeringToolsArchiveURL`"
        if [ $? -ne 0 ]
        then
            printf 'Unable to download URL: %s' "$peeringToolsArchiveURL"
            exit 1
        fi
        peeringToolsExtraction
        peersInstallation
    fi
}

sudoDetection
packageManagerDetection
cjdnsInstallation
peeringToolsDownload
