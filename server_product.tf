// server_product.tf

data "ncloud_server_product" "product" {
  server_image_product_code = var.Cent7_8  

  filter {
    name   = "product_code"
    values = ["HDD"]
    regex  = true
  }

  filter {
    name   = "cpu_count"
    values = ["2"]
  }

  filter {
    name   = "memory_size"
    values = ["4GB"]
  }

  filter {
    name   = "base_block_storage_size"
    values = ["50GB"]
  }

  filter {
    name   = "product_type"
    values = ["HICPU"]
  }
}