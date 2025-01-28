module "dynamodb_table" {
  source   = "terraform-aws-modules/dynamodb-table/aws"

  name     = "view-count-db"
  hash_key = "id"

  attributes = [
    {
      name = "id"
      type = "N"
    }
  ]
}