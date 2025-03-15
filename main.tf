terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.73.1"
    }
  }
}

provider "huaweicloud" {
  region     = "cn-east-3"     #实际的区域
#   access_key = var.hw_access_key #前面获取的key
#   secret_key = var.hw_secret_key #前面获取的key
}

resource "huaweicloud_fgs_function" "fgs_function" {
  name        = "test_func_cations"
  app         = "default"
  description = "function test"
  handler     = "index.handler"
  memory_size = 128
  timeout     = 3
  runtime     = "Python3.9"
  code_type   = "inline"
  func_code   = "aW1wb3J0IGpzb24KZGVmIGhhbmRsZXIgKGV2ZW50LCBjb250ZXh0KToKICAgIG91dHB1dCA9ICdIZWxsbyBtZXNzYWdlOiAnICsganNvbi5kdW1wcyhldmVudCkKICAgIHJldHVybiBvdXRwdXQ="
}