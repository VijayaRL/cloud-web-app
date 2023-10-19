# Resource Group 

resource "aws_resourcegroups_group" "resource_group" {
  name = "${var.project_name}-${var.project_suffix}"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": ["AWS::AllSupported"],
  "TagFilters": [
    {
      "Key": "Project",
      "Values": ["${var.project_name}-${var.project_suffix}"]
    }
  ]
}
JSON
  }
}