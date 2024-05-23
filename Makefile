ENV_NAME = ngs_research
DRIVE_NAME = F
MOUNT_PATH = /mnt/f
FASTQC_VERSION = 0.12.1

.PHONY: mount_drive
mount_drive:
	sudo mkdir -p ${MOUNT_PATH}
	sudo mount -t drvfs ${DRIVE_NAME}: ${MOUNT_PATH}

.PHONY: install_r
install_r:
	sudo apt update
	wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
	sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
	sudo apt install r-base

.PHONY: install_ubuntu_library
install_ubuntu_library:
	sudo apt update
	sudo apt install default-jre

.PHONY: install_sratoolkit
install_sratoolkit:
	sudo mkdir -p ${MOUNT_PATH}/${ENV_NAME}/pkg/
	echo "sratoolkit install: https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit"
	curl \
        -o sratoolkit.tar.gz \
        https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-centos_linux64.tar.gz
	sudo tar -vxzf sratoolkit.tar.gz --directory ${MOUNT_PATH}/${ENV_NAME}/pkg/
	rm sratoolkit.tar.gz

.PHONY: install_fastqc
install_fastqc:
	sudo mkdir -p ${MOUNT_PATH}/${ENV_NAME}/pkg/
	echo "FastQC install: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/?"
	curl \
        -o fastqc_v${FASTQC_VERSION}.zip \
        https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${FASTQC_VERSION}.zip
	sudo unzip fastqc_v${FASTQC_VERSION}.zip -d ${MOUNT_PATH}/${ENV_NAME}/pkg/
	rm -rf fastqc_v${FASTQC_VERSION}.zip

.PHONY: install_kallisto
install_kallisto:
	sudo apt update
	sudo apt install cmake
	echo "kallisto install: https://github.com/pachterlab/kallisto/blob/master/INSTALL.md"
	git clone https://github.com/pachterlab/kallisto.git
	mkdir -p kallisto/build
	cd kallisto/build
	cmake .. | make | sudo make install
	cd ../../
	rm kallisto/