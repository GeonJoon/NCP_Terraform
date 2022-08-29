## 고객사 Access_key 입력
variable access_key {
  default     = "104CF8842C7EA6140A02"
}

## 고객사 secret_key 입력
variable secret_key {
  default     = "F6B88FE7E3465A26570C52C5C473BACD6BC3325D"
}

## 고객사명 지정 
variable name {
  default     = "uwsmsp-test"
}

## public 서브넷에 해당하는 서버 몰아 넣기 
variable "server_name" {
	type = list(string)
  default = ["uws-dev1","uws-dev2", "uws-web1", "uws-web2", "uws-bastion"]
}

##Cent7.3
variable Cent7_3 {
  default     = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
}

##Cent7.8
variable Cent7_8 {
  default     = "SW.VSVR.OS.LNX64.CNTOS.0708.B050"
}

##UBUNTU 16.04
variable "UBNTU16_04" {
  default     = "SW.VSVR.OS.LNX64.UBNTU.SVR1604.B050"
}

##UBUNTU 18.04
variable "UBNTU18_04" {
  default     = "SW.VSVR.OS.LNX64.UBNTU.SVR1804.B050"
}

##UBUNTU 20.04
variable "UBNTU20_04" {
  default     = "SW.VSVR.OS.LNX64.UBNTU.SVR2004.B050"
}

variable "nic" {
  type = list
  default = ["10.200.1.10", "10.200.1.11", "10.200.1.12", "10.200.1.13"]
}