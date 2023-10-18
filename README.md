# Storage Insights Reporting Module

A pattern for creating your Google Cloud Storage Insights reports :robot:

![TFSec Security Checks](https://github.com/withriley/template-terraform-module/actions/workflows/main.yml/badge.svg)
![terraform-docs](https://github.com/withriley/template-terraform-module/actions/workflows/terraform-docs.yml/badge.svg)
![auto-release](https://github.com/withriley/template-terraform-module/actions/workflows/release.yml/badge.svg)

## Usage Instructions :sparkles:

1. Call this module using the example (below) as a starting point. Pass any additional optional parameters you require.

## Caveats :warning:

All of the source storage buckets passed to this module MUST be in the same project. If you want to configure Storage Insights on buckets from different projects, you will need to call the module for each project. Typically this is not an issue as most organizations will use Google's landing zone which seperates TF code by project. 

<!-- BEGIN_TF_DOCS -->


## Example

```hcl

```

## Resources

No resources.

## Modules

No modules.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
