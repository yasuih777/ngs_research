ENV_NAME = ngs_research
DRIVE_NAME = F
MOUNT_PATH = /mnt/f

.PHONY: install_miniconda
install_miniconda:
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
	bash Miniconda3-latest-Linux-x86_64.sh
	rm Miniconda3-latest-Linux-x86_64.sh

.PHONY: update_conda_channel
update_conda_channel:
	conda config --add channels bioconda
	conda config --add channels r
	conda config --add channels conda-forge
	conda config --remove channels defaults

.PHONY: install_conda_extra
install_conda_extra:
	conda install -y -c conda-forge mamba

.PHONY: create_environment
create_environment:
	conda env create -n ${ENV_NAME} --file environment.yaml

.PHONY: export_environment
export_environment:
	conda env export | grep -v "^prefix: " > environment.yaml

.PHONY: mount_drive
mount_drive:
	sudo mkdir -p ${MOUNT_PATH}
	sudo mount -t drvfs ${DRIVE_NAME}: ${MOUNT_PATH}