module "storage_insights" {
  source         = "github.com/withriley/storage-insights"
  project        = "my-project"
  source_buckets = ["bucket1", "bucket2", "bucket3"]
  start_date = {
    day   = 20
    month = 10
    year  = 2023
  }
  end_date = {
    day   = 18
    month = 10
    year  = 2024
  }
}
