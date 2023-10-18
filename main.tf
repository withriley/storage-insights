// get all buckets that were passed as a variable
data "google_storage_bucket" "buckets" {
  for_each = toset(var.source_buckets)
  name     = each.value
}

// generate local that contains unique locations for all buckets
locals {
  bucket_locations = [for bucket in data.google_storage_bucket.buckets : bucket.location]
  unique_locations = distinct(local.bucket_locations)
}

// create random suffix for each location in unique_location (used for report bucket name)
resource "random_id" "suffix" {
  for_each    = toset(local.unique_locations)
  byte_length = 4
}

// create report bucket for each unique location
resource "google_storage_bucket" "report_bucket" {
  for_each                    = toset(local.unique_locations)
  name                        = "storage-insights-${random_id.suffix[each.key].hex}"
  project                     = var.project
  location                    = each.key
  force_destroy               = true
  uniform_bucket_level_access = true
}

// add permissions to source buckets to allow storage insights to read data
resource "google_storage_bucket_iam_member" "insights" {
  for_each = data.google_storage_bucket.buckets
  bucket   = data.google_storage_bucket.buckets[each.key].name
  role     = "roles/storage.insightsCollectorService"
  member   = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-storageinsights.iam.gserviceaccount.com"
}

// add permissions to report buckets to allow storage insights to write data
resource "google_storage_bucket_iam_member" "admin" {
  for_each = google_storage_bucket.report_bucket
  bucket   = google_storage_bucket.report_bucket[each.key].name
  role     = "roles/storage.objectAdmin"
  member   = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-storageinsights.iam.gserviceaccount.com"
}

// create storage insights report
resource "google_storage_insights_report_config" "config" {
  for_each     = data.google_storage_bucket.buckets
  display_name = "${var.prefix} - ${each.value.name}"
  location     = lower(each.value.location)
  frequency_options {
    frequency = var.frequency
    start_date {
      day   = var.start_date.day
      month = var.start_date.month
      year  = var.start_date.year
    }
    end_date {
      day   = var.end_date.day
      month = var.end_date.month
      year  = var.end_date.year
    }
  }
  csv_options {
    record_separator = var.csv_options.record_separator
    delimiter        = var.csv_options.delimiter
    header_required  = var.csv_options.header_required
  }
  object_metadata_report_options {
    metadata_fields = var.metadata_fields
    storage_filters {
      bucket = data.google_storage_bucket.buckets[each.key].name
    }
    storage_destination_options {
      bucket           = google_storage_bucket.report_bucket[each.value.location].name
      destination_path = "reports/${each.value.name}/"
    }
  }

  depends_on = [google_storage_bucket_iam_member.admin]
}


