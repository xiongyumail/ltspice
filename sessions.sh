#!/bin/bash
IMAGE_NAME="ltspice"
IMAGE_VERSION="1.0.0"

WORK_PATH=$(cd $(dirname $0); pwd)
echo "WORK_PATH: ${WORK_PATH}"

export PROJECTS_PATH=/home/${MY_NAME}/projects

session=${MY_NAME}

tmux has-session -t $session >/dev/null 2>&1
if [ $? = 0 ];then
    tmux attach-session -t $session
    exit
fi

tmux new-session -d -s $session -n ${MY_NAME}
tmux split-window -t $session:0 -h

if [ ! -d "/home/${MY_NAME}/LTspiceXVII/lib" ]; then
    tmux send-keys -t $session:0.0 'cd ${PROJECTS_PATH};wine /home/${MY_NAME}/workspace/tools/LTspiceXVII.exe' C-m
else
    tmux send-keys -t $session:0.0 'cd ${PROJECTS_PATH};wine ${WINE_PATH}/LTC/LTspiceXVII/XVIIx86.exe' C-m
fi
tmux send-keys -t $session:0.1 'cd ${PROJECTS_PATH};' C-m

tmux select-pane -t $session:0.1
tmux attach-session -t $session