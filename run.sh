#!/bin/bash
echo "This is a test for extension"


RABBITMQSERVER_VERSION="3.6.16-2"

log ()
{
    echo "[$(date +'%F %T.%6N')]: $*"
}

install_package ()
{
    local package="$1"
    echo ""
    log "Installing package ${package}..."
    local retry=0
    local max_retry=3
    while true ; do
        ((retry++))
        sudo apt-get update
        sudo apt-get install -y ${package}
        exit_code=$?
        if [[ $exit_code -eq 0 ]]; then
            log "Successfully installed package ${package}"
            break
        fi
        log "Last exit code is ${exit_code}"
        if [[ $retry -le $max_retry ]]; then
            echo ""
            log "(${retry}/$max_retry) Wait 5 seconds to retry to install package ${package}"
            sleep 5
        else
            echo ""
            log "Unable to install package ${package} !"
            break
        fi
    done
}

install_erlang_rabbitmqserver ()
{
    echo ""
    log "-----------------------------Installing erlang and rabbitmq server-----------------------------"
    log "Configing hostname resolution"
    
    echo "deb https://dl.bintray.com/rabbitmq/debian xenial main" | sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list
    
    wget -O - "https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc" | sudo apt-key add -
    
    sudo apt-get update
    
    install_package "apt-transport-https"
            
    install_package "rabbitmq-server=$RABBITMQSERVER_VERSION"
    
    install_package "jq"
    
    log "-----------------------------Installed erlang and rabbitmq server-----------------------------"
}

install_erlang_rabbitmqserver
