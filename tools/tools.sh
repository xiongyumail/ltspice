#!/bin/bash
WORK_PATH=$(cd $(dirname $0); pwd)
TEMP_PATH=~/workspace/.tmp/${MY_NAME}
echo "WORK_PATH: ${WORK_PATH}"
echo "TEMP_PATH: ${TEMP_PATH}"

sudo apt-get update
sudo chown -R ${MY_NAME}:${MY_NAME} /home/${MY_NAME}/workspace

if [ ! -d "${TEMP_PATH}" ]; then
   mkdir -p ${TEMP_PATH}
fi
cd ${TEMP_PATH}
if [ ! -d ".config" ]; then
   mkdir .config
fi
if [ ! -d ".tools" ]; then
   mkdir .tools
fi

cd ${TEMP_PATH}/.config
if [ ! -d ".config" ]; then
   mkdir .config
   sudo rm -rf ~/.config
   sudo ln -s $PWD/.config ~/.config
fi
if [ ! -d ".tmux" ]; then
   mkdir .tmux
   sudo rm -rf ~/.tmux
   sudo ln -s $PWD/.tmux ~/.tmux
fi
if [ ! -d ".local" ]; then
   mkdir .local
   sudo rm -rf ~/.local
   sudo ln -s $PWD/.local ~/.local
fi
if [ ! -d ".ipython" ]; then
   mkdir .ipython
   sudo rm -rf ~/.ipython
   sudo ln -s $PWD/.ipython ~/.ipython
fi
if [ ! -d ".pki" ]; then
   mkdir .pki
   sudo rm -rf ~/.pki
   sudo ln -s $PWD/.pki ~/.pki
fi
if [ ! -d ".cache" ]; then
   mkdir .cache
   sudo rm -rf ~/.cache
   sudo ln -s $PWD/.cache ~/.cache
fi
if [ ! -d ".wine" ]; then
   mkdir .wine
   sudo rm -rf ~/.wine
   sudo ln -s $PWD/.wine ~/.wine
fi
if [ ! -d "LTspiceXVII" ]; then
   mkdir LTspiceXVII
   sudo rm -rf ~/LTspiceXVII
   sudo ln -s $PWD/LTspiceXVII ~/LTspiceXVII
fi

# wine
sudo dpkg --add-architecture i386
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
      wine32
if [ ! -f "${TEMP_PATH}/.tools/wine" ]; then
   cd ${WORK_PATH}
   ln -s ~/.wine/drive_c/"Program Files" ~/Program_Files
   echo "export WINE_PATH=~/Program_Files" >> ${HOME}/.bashrc
   echo "wine install ok" >> ${TEMP_PATH}/.tools/wine
fi

# tmux
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
   tmux
if [ ! -f "${TEMP_PATH}/.tools/tmux" ]; then
   cd ${WORK_PATH}
   cd tmux
   ln -s $PWD/.tmux.conf ~/.tmux.conf
   echo "export TMUX_PATH=${TEMP_PATH}/tmux" >> ${HOME}/.bashrc
   echo "tmux install ok" >> ${TEMP_PATH}/.tools/tmux
fi

sudo apt-get clean
sudo apt-get autoclean
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
sudo rm -rf /var/cache/*
sudo rm -rf /var/lib/apt/lists/*
