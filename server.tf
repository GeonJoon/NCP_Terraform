## init-script 생성 
resource "ncloud_init_script" "init" {
  name    = "apm-script"
  description   = "apm 설치"
  content = "#!/bin/bash\nyum install -y httpd\nyum install -y php\ncd /usr/local/src/\nwget https://github.com/juhanyun/uwslab/archive/refs/heads/main.zip\nunzip main.zip\nmv uwslab-main/* /var/www/html/\nsystemctl start httpd\nsystemctl enable httpd\nyum -y install https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm\nrpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022\nyum -y install mysql-community-server\nmysqld --initialize-insecure --user=mysql\nsystemctl start mysqld\nsystemctl enable mysqld"
}

## 서버 로그인 키 생성 및 로컬 다운로드 
resource "ncloud_login_key" "loginkey" {
  key_name = "key-${var.name}"
}

resource "local_file" "pem_key" {
  filename = "${ncloud_login_key.loginkey.key_name}.pem"
  content = ncloud_login_key.loginkey.private_key
}

## 서버 생성
resource "ncloud_server" "server_bastion" {
    subnet_no                 = ncloud_subnet.subnet1.id
    name                      = var.server_name[4]
    server_image_product_code = var.Cent7_8
    server_product_code       = data.ncloud_server_product.product.id
    login_key_name            = ncloud_login_key.loginkey.key_name
    network_interface {
      network_interface_no  = ncloud_network_interface.nic_bastion.id
      order                 = 0
    }
}

resource "ncloud_server" "dev_server" {
    count                     = 2
    subnet_no                 = ncloud_subnet.subnet2.id
    name                      = element(var.server_name, count.index)
    server_image_product_code = var.UBNTU18_04
    server_product_code       = data.ncloud_server_product.product.id
    login_key_name            = ncloud_login_key.loginkey.key_name
    network_interface {
      network_interface_no  = ncloud_network_interface.web_dev_server[count.index].id
      order                 = 0
    }
}

resource "ncloud_server" "web_server" {
    count                     = 2
    subnet_no                 = ncloud_subnet.subnet2.id
    name                      = element(var.server_name, count.index+2)
    server_image_product_code = var.Cent7_8
    server_product_code       = data.ncloud_server_product.product.id
    login_key_name            = ncloud_login_key.loginkey.key_name
    init_script_no            = ncloud_init_script.init.id
    network_interface {
      network_interface_no  = ncloud_network_interface.web_dev_server[count.index+2].id
      order                 = 0
    }
}

## Public IP 할당
resource "ncloud_public_ip" "public_ip" {
    server_instance_no        = ncloud_server.server_bastion.id
}

## web 서버 blockstorage 부착 
resource "ncloud_block_storage" "storage" {
    count              = 2
    server_instance_no = ncloud_server.web_server[count.index].id
    name               = "ssd-${element(var.server_name, count.index+2)}"
    size               = "10"
    disk_detail_type   = "SSD"
}
