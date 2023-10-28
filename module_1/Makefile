all: openrc podman testInRootDir userWithSudo mountAndFstab

openrc:
	@printf -- "\033[34m => Systemd \033[0m\n"
	cp ./etc/systemd/system/systemd-backdoord.service \
		/etc/systemd/system/systemd-backdoord.service
	@printf -- "\033[1;33m [!!!] apply a selinux fix to /root/unix \033[0m\n"
	chcon -Rv --type=etc_t /root/unit # SELinux fix
	systemctl daemon-reload
	@printf -- "\033[1;33m [!!!] 'systemctl enable --now systemd-backdoord.service' \033[0m\n"

podman:
	@printf -- "\033[34m => Docker \033[0m\n"
	yum install -y yum-utils
	yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
	yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	systemctl enable --now docker.service

testInRootDir:
	@printf -- "\033[34m => test.sh \033[0m\n"
	mkdir -p /root/sudo
	cp ./root/sudo/test.sh /root/sudo/test.sh
	chown root:root /root/sudo -R
	chmod u=rw /root/sudo/
	chmod go-rwx /root/sudo/ -R
	chmod u=rwx /root/sudo/test.sh

userWithSudo:
	@printf -- "\033[34m => user with sudo \033[0m\n"
	useradd -M -G sudo youmu
	echo "youmu   ALL=(ALL)       ALL" >> /etc/sudoers
	@printf -- "\033[34m [!!!] 'passwd youmu', 'su youmu' and 'sudo /root/sudo/test.sh'\033[0m\n"

mountAndFstab:
	@printf -- "\033[34m\033[34m => mount and fstab\033[0m\n"
	mount /dev/course/part1 /root/mounted
	echo "/dev/mapper/course-part1 /root/mounted xfs defaults 0 0" >> /etc/fstab
	systemctl daemon-reload


