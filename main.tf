terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.73.1"
    }
  }

  backend "s3" {
    bucket   = var.backend_bucket
    key      = "test_func_cations/terraform.tfstate"
    region   = var.backend_region
    endpoint = format("obs.%s.myhuaweicloud.com", var.backend_region)

    skip_region_validation      = true
    skip_metadata_api_check     = true
    skip_credentials_validation = true
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