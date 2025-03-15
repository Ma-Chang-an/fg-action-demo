terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.73.1"
    }
  }

  backend "s3" {
    bucket  = "backend-bucket"
    key     = "test_func_cations/terraform.tfstate"
    region  = "cn-east-3"

    # 关键修复点 1：使用 endpoints.s3 代替废弃的 endpoint
    endpoints = {
      s3 = "https://obs.cn-east-3.myhuaweicloud.com"  # 必须包含协议头
    }

    # 关键修复点 2：强制路径格式（华为云 OBS 必须开启）
    force_path_style = true

    # 跳过 AWS 校验逻辑
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true  # 禁止获取 AWS 账户 ID
  }
}

provider "huaweicloud" {}

resource "huaweicloud_fgs_function" "fgs_function" {
  name        = "test_func_cations"
  app         = "default"
  description = "function test"
  handler     = "index.handler"
  memory_size = 256
  timeout     = 3
  runtime     = "Python3.9"
  code_type   = "inline"
  func_code   = "aW1wb3J0IGpzb24KZGVmIGhhbmRsZXIgKGV2ZW50LCBjb250ZXh0KToKICAgIG91dHB1dCA9ICdIZWxsbyBtZXNzYWdlOiAnICsganNvbi5kdW1wcyhldmVudCkKICAgIHJldHVybiBvdXRwdXQ="
}