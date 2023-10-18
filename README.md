![TFSec Security Checks](https://github.com/withriley/template-terraform-module/actions/workflows/main.yml/badge.svg)
![terraform-docs](https://github.com/withriley/template-terraform-module/actions/workflows/terraform-docs.yml/badge.svg)
![auto-release](https://github.com/withriley/template-terraform-module/actions/workflows/release.yml/badge.svg)

# Storage Insights Reporting Module

A pattern for creating your Google Cloud Storage Insights reports :robot:

This module will create a destination reporting bucket for any number of source storage buckets you pass to it. It will also create a storage insights report config for each source bucket you pass to it. 

## Usage Instructions :sparkles:

Call this module using the example (below) as a starting point. Pass any additional optional parameters you require.

## Caveats :warning:

All of the source storage buckets passed to this module MUST be in the same project. If you want to configure Storage Insights on buckets from different projects, you will need to call the module for each project. Typically this is not an issue as most organizations will use Google's landing zone which seperates TF code by project. 

<!-- BEGIN_TF_DOCS -->


## Example

```hcl
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
```

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.report_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_iam_member.insights](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_insights_report_config.config](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_insights_report_config) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |
| [google_storage_bucket.buckets](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_bucket) | data source |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_csv_options"></a> [csv\_options](#input\_csv\_options) | The CSV options for the storage insights report. | <pre>object({<br>    record_separator = string<br>    delimiter        = string<br>    header_required  = bool<br>  })</pre> | <pre>{<br>  "delimiter": ",",<br>  "header_required": false,<br>  "record_separator": "\n"<br>}</pre> | no |
| <a name="input_end_date"></a> [end\_date](#input\_end\_date) | The end date for the storage insights report. | <pre>object({<br>    day   = number<br>    month = number<br>    year  = number<br>  })</pre> | n/a | yes |
| <a name="input_frequency"></a> [frequency](#input\_frequency) | Frequency for the storage insights report. | `string` | `"WEEKLY"` | no |
| <a name="input_metadata_fields"></a> [metadata\_fields](#input\_metadata\_fields) | The metadata fields to include in the storage insights report. | `list(string)` | <pre>[<br>  "project",<br>  "bucket",<br>  "name",<br>  "location",<br>  "size",<br>  "timeCreated",<br>  "timeDeleted",<br>  "updated",<br>  "storageClass",<br>  "etag",<br>  "retentionExpirationTime",<br>  "crc32c",<br>  "md5Hash",<br>  "generation",<br>  "metageneration",<br>  "contentType",<br>  "contentEncoding",<br>  "timeStorageClassUpdated"<br>]</pre> | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix to add to the storage insights report config display name. | `string` | `"Storage Insights Report"` | no |
| <a name="input_project"></a> [project](#input\_project) | The project to deploy the storage insights reports to. | `string` | n/a | yes |
| <a name="input_source_buckets"></a> [source\_buckets](#input\_source\_buckets) | A list of the storage buckets you want to configure reports on. | `list(string)` | n/a | yes |
| <a name="input_start_date"></a> [start\_date](#input\_start\_date) | The start date for the storage insights report. | <pre>object({<br>    day   = number<br>    month = number<br>    year  = number<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
