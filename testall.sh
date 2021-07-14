#!/bin/bash
# for container 
pushd /root/
#sh /root/installperf.sh


#tar xvf pkgscontainer.tar.gz
#sh ansibleprepcontainer.sh 172.18.123.49 123456

rsync -av /root/hosts2 /usr/share/ansible-runner-service/project/hosts
set -e
## first part teset 
#echo "-------------------- restrpm,resetrpmperf,resetvolume rawdiskpart"
#docker container  exec -it runner-service ansible-playbook --tags=resetrpm,resetrpmperf,resetvolume  --extra-vars '{"cleanup_vars":"files/cleanup-varsrawdiskpart.yaml"}' -i hosts deploy.yml|& tee log01resetrawdiskpart
##
#echo "-------------------- install rawdiskpart"
#docker container  exec -it runner-service ansible-playbook -vv --tags=freshinstall,sethostname,ipconfig,hosts,ntp,perf --extra-vars '{"backend_variables":"files/backend-varsrawdiskpart.yaml"}' -i hosts deploy.yml|& tee log02installrawdiskpart
#echo "-------------------- restrpm,resetrpmperf,resetvolume rawdiskpart"
#docker container  exec -it runner-service ansible-playbook --tags=resetrpm,resetrpmperf,resetvolume  --extra-vars '{"cleanup_vars":"files/cleanup-varsrawdiskpart.yaml"}' -i hosts deploy.yml|& tee log03resetrawdiskpart
#

# lvm test 
#sh /root/installperf.sh
echo "-------------------- restrpm,resetrpmperf,resetvolume lvm"
docker container  exec -it runner-service ansible-playbook --tags=resetrpm,resetrpmperf,resetvolume -i hosts deploy.yml |& tee log1resetlvm
echo "-------------------- install  lvm"
docker container  exec -it runner-service ansible-playbook --tags=freshinstall,sethostname,ipconfig,hosts,ntp,perf -vv -i hosts deploy.yml|& tee log2installlvm


echo "-------------------- restrpm,resetrpmperf,resetvolume lvm"
docker container  exec -it runner-service ansible-playbook --tags=resetrpm,resetrpmperf,resetvolume -i hosts deploy.yml|& tee log3resetlvm




#sh /root/installperfraw.sh
echo "-------------------- restrpm,resetrpmperf,resetvolume rawdisk"
docker container  exec -it runner-service ansible-playbook --tags=resetrpm,resetrpmperf,resetvolume  --extra-vars '{"cleanup_vars":"files/cleanup-varsrawdisk.yaml"}' -i hosts deploy.yml|& tee log4resetrawdisk

echo "-------------------- install rawdisk"
docker container  exec -it runner-service ansible-playbook -vv --tags=freshinstall,sethostname,ipconfig,hosts,ntp,perf --extra-vars '{"backend_variables":"files/backend-varsrawdisk.yaml"}' -i hosts deploy.yml|& tee log5installrawdisk
 
echo "-------------------- restrpm,resetrpmperf,resetvolume rawdisk"
docker container  exec -it runner-service ansible-playbook --tags=resetrpm,resetrpmperf,resetvolume  --extra-vars '{"cleanup_vars":"files/cleanup-varsrawdisk.yaml"}' -i hosts deploy.yml|& tee log6resetrawdisk
#
#
#
#
#sh /root/installperfrawpart.sh
echo "-------------------- restrpm,resetrpmperf,resetvolume rawdiskpart"
docker container  exec -it runner-service ansible-playbook --tags=resetrpm,resetrpmperf,resetvolume  --extra-vars '{"cleanup_vars":"files/cleanup-varsrawdiskpart.yaml"}' -i hosts deploy.yml|& tee log7resetrawdiskpart
#
echo "-------------------- install rawdiskpart"
docker container  exec -it runner-service ansible-playbook -vv --tags=freshinstall,sethostname,ipconfig,hosts,ntp,perf --extra-vars '{"backend_variables":"files/backend-varsrawdiskpart.yaml"}' -i hosts deploy.yml|& tee log8installrawdiskpart
echo "-------------------- restrpm,resetrpmperf,resetvolume rawdiskpart"
docker container  exec -it runner-service ansible-playbook --tags=resetrpm,resetrpmperf,resetvolume  --extra-vars '{"cleanup_vars":"files/cleanup-varsrawdiskpart.yaml"}' -i hosts deploy.yml|& tee log9resetrawdiskpart
#popd
## for host 
