variable "source_buckets" {
  type = list(string)
  description = "A list of the storage buckets you want to configure reports on."
}
variable "project" {
  type = string
  description = "The project to deploy the storage insights reports to."
}
variable "start_date" {
  type = object({
    day   = number
    month = number
    year  = number
  })
  description = "The start date for the storage insights report."
}
variable "end_date" {
  type = object({
    day   = number
    month = number
    year  = number
  })
  description = "The end date for the storage insights report."
}
variable "csv_options" {
  type = object({
    record_separator = string
    delimiter        = string
    header_required  = bool
  })
  default = {
    record_separator = "\n"
    delimiter        = ","
    header_required  = false
  }
  description = "The CSV options for the storage insights report."
}
variable "prefix" {
  type    = string
  default = "Storage Insights Report"
  description = "The prefix to add to the storage insights report config display name."
}
variable "metadata_fields" {
  type = list(string)
  default = [
    "project",
    "bucket",
    "name",
    "location",
    "size",
    "timeCreated",
    "timeDeleted",
    "updated",
    "storageClass",
    "etag",
    "retentionExpirationTime",
    "crc32c",
    "md5Hash",
    "generation",
    "metageneration",
    "contentType",
    "contentEncoding",
    "timeStorageClassUpdated"
  ]
  description = "The metadata fields to include in the storage insights report."
}
variable "frequency" {
  type    = string
  default = "WEEKLY"
  description = "Frequency for the storage insights report."
}