PROJECT_NAME = ngs_research
DRIVE_NAME = F
MOUNT_PATH = /mnt/f
PYTHON_VERSION = 3.10.13
FASTQC_VERSION = 0.12.1
RSEM_VERSION = 1.3.3

# Drive setting
.PHONY: mount_drive
mount_drive:
	sudo mkdir -p ${MOUNT_PATH}
	sudo mount -t drvfs ${DRIVE_NAME}: ${MOUNT_PATH}

# R setting
.PHONY: install_r
install_r:
	sudo apt update
	wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
	sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
	sudo apt install r-base

# Python setting
.PHONY: install_pyenv
install_pyenv: # install python version maneger tool
	sudo apt update
	sudo apt upgrade
	sudo apt install \
		libssl-dev libffi-dev libncurses5-dev zlib1g zlib1g-dev \
		libreadline-dev libbz2-dev libsqlite3-dev make gcc
	curl https://pyenv.run | bash
	echo '' >> ~/.bashrc
	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
	echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
	echo 'eval "$(pyenv init --path)"' >> ~/.bashrc

.PHONY: setup_python
setup_python:
	pyenv install -s ${PYTHON_VERSION}
	pyenv local ${PYTHON_VERSION}

# Ubuntu setting
.PHONY: install_ubuntu_library
install_ubuntu_library:
	sudo apt update
	sudo apt install default-jre

# DRY analytics setting
.PHONY: install_sratoolkit
install_sratoolkit:
	sudo mkdir -p ${MOUNT_PATH}/${PROJECT_NAME}/pkg/
	echo "sratoolkit install: https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit"
	curl \
        -o sratoolkit.tar.gz \
        https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-centos_linux64.tar.gz
	sudo tar -vxzf sratoolkit.tar.gz --directory ${MOUNT_PATH}/${PROJECT_NAME}/pkg/
	rm sratoolkit.tar.gz

.PHONY: install_fastqc
install_fastqc:
	sudo mkdir -p ${MOUNT_PATH}/${PROJECT_NAME}/pkg/
	echo "FastQC install: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/?"
	curl \
        -o fastqc_v${FASTQC_VERSION}.zip \
        https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${FASTQC_VERSION}.zip
	sudo unzip fastqc_v${FASTQC_VERSION}.zip -d ${MOUNT_PATH}/${PROJECT_NAME}/pkg/
	rm -rf fastqc_v${FASTQC_VERSION}.zip

.PHONY: install_hisat2
install_hisat2:
	sudo mkdir -p ${MOUNT_PATH}/${PROJECT_NAME}/pkg/
	echo "HISAT2 install: https://daehwankimlab.github.io/hisat2/"
	curl \
        -o hisat2.zip \
        https://cloud.biohpc.swmed.edu/index.php/s/oTtGWbWjaxsQ2Ho/download
	sudo unzip hisat2.zip -d /mnt/f/ngs_research/pkg/
	rm -rf hisat2.zip
