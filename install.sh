#!/bin/bash
SH_PATH=$(cd "$(dirname "$0")";pwd)
cd ${SH_PATH}

create_mainfest_file(){
    echo "进行配置。。。"
    read -p "请输入你的应用名称：" IBM_APP_NAME
    echo "应用名称：${IBM_APP_NAME}"
    read -p "请输入你的应用内存大小(默认256)：" IBM_MEM_SIZE
    if [ -z "${IBM_MEM_SIZE}" ];then
	IBM_MEM_SIZE=256
    fi
    echo "内存大小：${IBM_MEM_SIZE}"
    
    
    cat >  ${SH_PATH}/IBMYes/v2ray-cloudfoundry/manifest.yml  << EOF
    applications:
    - path: .
      name: ${IBM_APP_NAME}
      random-route: true
      memory: ${IBM_MEM_SIZE}M
EOF

     echo "配置完成。"
}

clone_repo(){
    echo "进行初始化。。。"
    git clone https://github.com/CCChieh/IBMYes
    cd IBMYes
    git submodule update --init --recursive
    cd v2ray-cloudfoundry/v2ray
    chmod +x *
    cd ${SH_PATH}/IBMYes/v2ray-cloudfoundry
    echo "初始化完成。"
}

install(){
    echo "进行安装。。。"
    cd ${SH_PATH}/IBMYes/v2ray-cloudfoundry
    UUID=$(cat /proc/sys/kernel/random/uuid)
    echo "uuid: " $UUID
    sed -i "s/id\": .*\"/id\": \"$UUID\"/g" ./v2ray/config.json
    ibmcloud target --cf
    ibmcloud cf install
    ibmcloud cf push
    echo "安装完成。"
}

clone_repo
create_mainfest_file
install
exit 0
