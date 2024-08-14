## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.115.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.115.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iothub"></a> [iothub](#module\_iothub) | git@github.com:mikamakusa/terraform-azure-iothub.git | n/a |
| <a name="module_log_analytics"></a> [log\_analytics](#module\_log\_analytics) | git@github.com:mikamakusa/terraform-azure-log-analytics | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_advanced_threat_protection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/advanced_threat_protection) | resource |
| [azurerm_iot_security_device_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iot_security_device_group) | resource |
| [azurerm_iot_security_solution.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iot_security_solution) | resource |
| [azurerm_security_center_assessment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_assessment) | resource |
| [azurerm_security_center_assessment_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_assessment_policy) | resource |
| [azurerm_security_center_auto_provisioning.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_auto_provisioning) | resource |
| [azurerm_security_center_automation.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_automation) | resource |
| [azurerm_security_center_contact.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_contact) | resource |
| [azurerm_security_center_server_vulnerability_assessment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_server_vulnerability_assessment) | resource |
| [azurerm_arc_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/arc_machine) | data source |
| [azurerm_eventhub.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub) | data source |
| [azurerm_eventhub_authorization_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_namespace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_namespace) | data source |
| [azurerm_logic_app_standard.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/logic_app_standard) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_machine) | data source |
| [azurerm_virtual_machine_scale_set.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_machine_scale_set) | data source |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_advanced_threat_protection"></a> [advanced\_threat\_protection](#input\_advanced\_threat\_protection) | n/a | <pre>list(object({<br>    id      = number<br>    enabled = bool<br>  }))</pre> | `[]` | no |
| <a name="input_arc_machine_name"></a> [arc\_machine\_name](#input\_arc\_machine\_name) | n/a | `string` | `null` | no |
| <a name="input_assessment"></a> [assessment](#input\_assessment) | n/a | <pre>list(object({<br>    id                   = number<br>    assessment_policy_id = any<br>    target_resource_id   = any<br>    additional_data      = optional(map(string))<br>    status = list(object({<br>      code        = string<br>      cause       = optional(string)<br>      description = optional(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_assessment_policy"></a> [assessment\_policy](#input\_assessment\_policy) | n/a | <pre>list(object({<br>    id                      = number<br>    description             = string<br>    display_name            = string<br>    severity                = optional(string)<br>    categories              = optional(list(string))<br>    implementation_effort   = optional(string)<br>    remediation_description = optional(string)<br>    threats                 = optional(list(string))<br>    user_impact             = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_automation"></a> [automation](#input\_automation) | n/a | <pre>list(object({<br>    id          = number<br>    name        = string<br>    scopes      = list(string)<br>    description = optional(string)<br>    enabled     = optional(bool)<br>    tags        = optional(map(string))<br>    action = list(object({<br>      resource_id       = string<br>      type              = string<br>      connection_string = optional(string)<br>      trigger_url       = optional(string)<br>    }))<br>    source = list(object({<br>      event_source = string<br>      rule_set = list(object({<br>        rule = list(object({<br>          expected_value = string<br>          operator       = string<br>          property_path  = string<br>          property_type  = string<br>        }))<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_contact"></a> [contact](#input\_contact) | n/a | <pre>list(object({<br>    id                  = number<br>    alert_notifications = bool<br>    alerts_to_admins    = bool<br>    email               = string<br>    name                = optional(string)<br>    phone               = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_iot_security_solution"></a> [iot\_security\_solution](#input\_iot\_security\_solution) | n/a | <pre>list(object({<br>    id                              = number<br>    display_name                    = string<br>    iothub_ids                      = any<br>    name                            = string<br>    enabled                         = optional(bool)<br>    events_to_export                = optional(set(string))<br>    log_analytics_workspace_id      = optional(any)<br>    log_unmasked_ips_enabled        = optional(bool)<br>    query_for_resources             = optional(string)<br>    query_subscription_ids          = optional(set(string))<br>    tags                            = optional(map(string))<br>    additional_workspace_id         = optional(any)<br>    additional_workspace_data_types = optional(list(string))<br>    recommendations_enabled = optional(list(object({<br>      acr_authentication               = optional(bool)<br>      agent_send_unutilized_msg        = optional(bool)<br>      baseline                         = optional(bool)<br>      edge_hub_mem_optimize            = optional(bool)<br>      edge_logging_option              = optional(bool)<br>      inconsistent_module_settings     = optional(bool)<br>      install_agent                    = optional(bool)<br>      ip_filter_deny_all               = optional(bool)<br>      ip_filter_permissive_rule        = optional(bool)<br>      open_ports                       = optional(bool)<br>      permissive_firewall_policy       = optional(bool)<br>      permissive_input_firewall_rules  = optional(bool)<br>      permissive_output_firewall_rules = optional(bool)<br>      privileged_docker_options        = optional(bool)<br>      shared_credentials               = optional(bool)<br>      vulnerable_tls_cipher_suite      = optional(bool)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_iothub"></a> [iothub](#input\_iothub) | n/a | `any` | `[]` | no |
| <a name="input_log_analytics_workspace"></a> [log\_analytics\_workspace](#input\_log\_analytics\_workspace) | n/a | `any` | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_security_center_auto_provisioning"></a> [security\_center\_auto\_provisioning](#input\_security\_center\_auto\_provisioning) | n/a | `string` | `null` | no |
| <a name="input_security_device_group"></a> [security\_device\_group](#input\_security\_device\_group) | n/a | <pre>list(object({<br>    id        = number<br>    iothub_id = any<br>    name      = string<br>    allow_rule = optional(list(object({<br>      connection_from_ips_not_allowed = optional(list(string))<br>      connection_to_ips_not_allowed   = optional(list(string))<br>      local_users_not_allowed         = optional(list(string))<br>      processes_not_allowed           = optional(list(string))<br>    })))<br>    range_rule = optional(list(object({<br>      duration = string<br>      max      = number<br>      min      = number<br>      type     = string<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_server_vulnerability_assessment"></a> [server\_vulnerability\_assessment](#input\_server\_vulnerability\_assessment) | n/a | <pre>list(object({<br>    id                 = number<br>    virtual_machine_id = any<br>    hybrid_machine_id  = any<br>  }))</pre> | `[]` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | n/a | `string` | `null` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_virtual_machine_name"></a> [virtual\_machine\_name](#input\_virtual\_machine\_name) | n/a | `string` | `null` | no |
| <a name="input_virtual_machine_scale_set_name"></a> [virtual\_machine\_scale\_set\_name](#input\_virtual\_machine\_scale\_set\_name) | n/a | `string` | `null` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_advanced_threat_protection_id"></a> [advanced\_threat\_protection\_id](#output\_advanced\_threat\_protection\_id) | n/a |
| <a name="output_iot_security_device_group_id"></a> [iot\_security\_device\_group\_id](#output\_iot\_security\_device\_group\_id) | n/a |
| <a name="output_iot_security_device_group_name"></a> [iot\_security\_device\_group\_name](#output\_iot\_security\_device\_group\_name) | n/a |
| <a name="output_iot_security_solution_id"></a> [iot\_security\_solution\_id](#output\_iot\_security\_solution\_id) | n/a |
| <a name="output_iot_security_solution_name"></a> [iot\_security\_solution\_name](#output\_iot\_security\_solution\_name) | n/a |
| <a name="output_server_vulnerability_assessment_id"></a> [server\_vulnerability\_assessment\_id](#output\_server\_vulnerability\_assessment\_id) | n/a |
