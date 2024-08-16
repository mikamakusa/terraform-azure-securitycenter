resource "azurerm_advanced_threat_protection" "this" {
  count              = length(var.advanced_threat_protection)
  enabled            = lookup(var.advanced_threat_protection[count.index], "enabled")
  target_resource_id = data.azurerm_storage_account.this.id
}

resource "azurerm_security_center_server_vulnerability_assessment" "this" {
  count              = length(var.server_vulnerability_assessment)
  virtual_machine_id = try(data.azurerm_virtual_machine.this.*.id, lookup(var.server_vulnerability_assessment[count.index], "virtual_machine_id"))
  hybrid_machine_id  = try(data.azurerm_arc_machine.this.*.id, lookup(var.server_vulnerability_assessment[count.index], "hybrid_machine_id"))
}

resource "azurerm_iot_security_device_group" "this" {
  count     = length(var.security_device_group)
  iothub_id = try(element(module.iothub.*.iothub_id, lookup(var.security_device_group[count.index], "iothub_id")))
  name      = lookup(var.security_device_group[count.index], "name")

  dynamic "allow_rule" {
    for_each = lookup(var.security_device_group[count.index], "allow_rule") == null ? [] : ["allow_rule"]
    content {
      connection_from_ips_not_allowed = lookup(allow_rule.value, "connection_from_ips_not_allowed")
      connection_to_ips_not_allowed   = lookup(allow_rule.value, "connection_to_ips_not_allowed")
      local_users_not_allowed         = lookup(allow_rule.value, "local_users_not_allowed")
      processes_not_allowed           = lookup(allow_rule.value, "processes_not_allowed")
    }
  }

  dynamic "range_rule" {
    for_each = lookup(var.security_device_group[count.index], "range_rule") == null ? [] : ["range_rule"]
    content {
      duration = lookup(range_rule.value, "duration")
      max      = lookup(range_rule.value, "max")
      min      = lookup(range_rule.value, "min")
      type     = lookup(range_rule.value, "type")
    }
  }
}

resource "azurerm_iot_security_solution" "this" {
  count                      = length(var.iot_security_solution)
  display_name               = lookup(var.iot_security_solution[count.index], "display_name")
  iothub_ids                 = [try(element(module.iothub.*.iothub_id, lookup(var.iot_security_solution[count.index], "iothub_ids")))]
  location                   = data.azurerm_resource_group.this.location
  name                       = lookup(var.iot_security_solution[count.index], "name")
  resource_group_name        = data.azurerm_resource_group.this.name
  disabled_data_sources      = ["TwinData"]
  enabled                    = lookup(var.iot_security_solution[count.index], "enabled")
  events_to_export           = lookup(var.iot_security_solution[count.index], "events_to_export")
  log_analytics_workspace_id = try(element(module.log_analytics.*.workspace_id, lookup(var.iot_security_solution[count.index], "log_analytics_workspace_id")))
  log_unmasked_ips_enabled   = lookup(var.iot_security_solution[count.index], "log_unmasked_ips_enabled")
  query_for_resources        = lookup(var.iot_security_solution[count.index], "query_for_resources")
  query_subscription_ids     = lookup(var.iot_security_solution[count.index], "query_subscription_ids")
  tags                       = merge(var.tags, lookup(var.iot_security_solution[count.index], "tags"))

  dynamic "additional_workspace" {
    for_each = (lookup(var.iot_security_solution[count.index], "additional_workspace_data_types") == null && lookup(var.iot_security_solution[count.index], "additional_workspace_id") == null) ? [] : ["additional_workspace"]
    content {
      data_types   = lookup(var.iot_security_solution[count.index], "additional_workspace_data_types")
      workspace_id = lookup(var.iot_security_solution[count.index], "additional_workspace_id")
    }
  }

  dynamic "recommendations_enabled" {
    for_each = lookup(var.iot_security_solution[count.index], "recommendations_enabled") == null ? [] : ["recommendations_enabled"]
    content {
      acr_authentication               = lookup(recommendations_enabled.value, "acr_authentication")
      agent_send_unutilized_msg        = lookup(recommendations_enabled.value, "agent_send_unutilized_msg")
      baseline                         = lookup(recommendations_enabled.value, "baseline")
      edge_hub_mem_optimize            = lookup(recommendations_enabled.value, "edge_hub_mem_optimize")
      edge_logging_option              = lookup(recommendations_enabled.value, "edge_logging_option")
      inconsistent_module_settings     = lookup(recommendations_enabled.value, "inconsistent_module_settings")
      install_agent                    = lookup(recommendations_enabled.value, "install_agent")
      ip_filter_deny_all               = lookup(recommendations_enabled.value, "ip_filter_deny_all")
      ip_filter_permissive_rule        = lookup(recommendations_enabled.value, "ip_filter_permissive_rule")
      open_ports                       = lookup(recommendations_enabled.value, "open_ports")
      permissive_firewall_policy       = lookup(recommendations_enabled.value, "permissive_firewall_policy")
      permissive_input_firewall_rules  = lookup(recommendations_enabled.value, "permissive_input_firewall_rules")
      permissive_output_firewall_rules = lookup(recommendations_enabled.value, "permissive_output_firewall_rules")
      privileged_docker_options        = lookup(recommendations_enabled.value, "privileged_docker_options")
      shared_credentials               = lookup(recommendations_enabled.value, "shared_credentials")
      vulnerable_tls_cipher_suite      = lookup(recommendations_enabled.value, "vulnerable_tls_cipher_suite")
    }
  }
}

resource "azurerm_security_center_assessment_policy" "this" {
  count                   = length(var.assessment_policy)
  description             = lookup(var.assessment_policy[count.index], "description")
  display_name            = lookup(var.assessment_policy[count.index], "display_name")
  severity                = lookup(var.assessment_policy[count.index], "severity")
  categories              = lookup(var.assessment_policy[count.index], "categories")
  implementation_effort   = lookup(var.assessment_policy[count.index], "implementation_effort")
  remediation_description = lookup(var.assessment_policy[count.index], "remediation_description")
  threats                 = lookup(var.assessment_policy[count.index], "threats")
  user_impact             = lookup(var.assessment_policy[count.index], "user_impact")
}

resource "azurerm_security_center_assessment" "this" {
  count                = length(var.assessment_policy) == 0 ? 0 : length(var.assessment)
  assessment_policy_id = try(element(azurerm_security_center_assessment_policy.this.*.id, lookup(var.assessment[count.index], "assessment_policy_id")))
  target_resource_id   = data.azurerm_virtual_machine_scale_set.this.id
  additional_data      = lookup(var.assessment[count.index], "additional_data")

  dynamic "status" {
    for_each = lookup(var.assessment[count.index], "status") == null ? [] : ["status"]
    content {
      code        = lookup(status.value, "code")
      cause       = lookup(status.value, "cause")
      description = lookup(status.value, "description")
    }
  }
}

resource "azurerm_security_center_auto_provisioning" "this" {
  auto_provision = var.security_center_auto_provisioning
}

resource "azurerm_security_center_automation" "this" {
  count               = length(var.automation)
  location            = data.azurerm_resource_group.this.location
  name                = lookup(var.automation[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = lookup(var.automation[count.index], "scopes")
  description         = lookup(var.automation[count.index], "description")
  enabled             = lookup(var.automation[count.index], "enabled")
  tags                = merge(var.tags, lookup(var.automation[count.index], "tags"))

  dynamic "action" {
    for_each = lookup(var.automation[count.index], "action")
    content {
      resource_id       = lookup(action.value, "type") == "loganalytics" ? module.log_analytics.workspace_id : lookup(action.value, "type") == "eventhub" ? data.azurerm_eventhub_namespace.this.id : data.azurerm_logic_app_standard.this.id
      type              = lookup(action.value, "type")
      connection_string = lookup(action.value, "type") == "eventhub" ? data.azurerm_eventhub_authorization_rule.this.primary_connection_string : null
      trigger_url       = lookup(action.value, "type") == "logicapp" ? data.azurerm_logic_app_standard.this : null
    }
  }

  dynamic "source" {
    for_each = lookup(var.automation[count.index], "source")
    content {
      event_source = lookup(source.value, "event_source")

      dynamic "rule_set" {
        for_each = lookup(source.value, "rule_set")
        content {
          dynamic "rule" {
            for_each = lookup(rule_set.value, "rule")
            content {
              expected_value = lookup(rule.value, "expected_value")
              operator       = lookup(rule.value, "operator")
              property_path  = lookup(rule.value, "property_path")
              property_type  = lookup(rule.value, "property_type")
            }
          }
        }
      }
    }
  }
}

resource "azurerm_security_center_contact" "this" {
  count               = length(var.contact)
  alert_notifications = lookup(var.contact[count.index], "alert_notifications")
  alerts_to_admins    = lookup(var.contact[count.index], "alerts_to_admins")
  email               = lookup(var.contact[count.index], "email")
  name                = lookup(var.contact[count.index], "name")
  phone               = lookup(var.contact[count.index], "phone")
}

resource "azurerm_security_center_server_vulnerability_assessment_virtual_machine" "this" {
  virtual_machine_id = data.azurerm_virtual_machine.this.id
}

resource "azurerm_security_center_server_vulnerability_assessments_setting" "name" {
  vulnerability_assessment_provider = "MdeTvm"
}

resource "azurerm_security_center_setting" "this" {
  count        = length(var.setting)
  enabled      = lookup(var.setting[count.index], "enabled")
  setting_name = lookup(var.setting[count.index], "setting_name")
}

resource "azurerm_security_center_storage_defender" "this" {
  count                                       = length(var.storage_defender)
  storage_account_id                          = data.azurerm_storage_account.this.id
  override_subscription_settings_enabled      = lookup(var.storage_defender[count.index], "override_subscription_settings_enabled")
  malware_scanning_on_upload_cap_gb_per_month = lookup(var.storage_defender[count.index], "malware_scanning_on_upload_cap_gb_per_month")
  malware_scanning_on_upload_enabled          = lookup(var.storage_defender[count.index], "malware_scanning_on_upload_enabled")
  sensitive_data_discovery_enabled            = lookup(var.storage_defender[count.index], "sensitive_data_discovery_enabled")
  scan_results_event_grid_topic_id            = lookup(var.storage_defender[count.index], "scan_results_event_grid_topic_id")
}

resource "azurerm_security_center_subscription_pricing" "this" {
  count         = length(var.subscription_pricing)
  tier          = lookup(var.subscription_pricing[count.index], "tier")
  resource_type = lookup(var.subscription_pricing[count.index], "resource_type")
  subplan       = lookup(var.subscription_pricing[count.index], "subplan")

  dynamic "extension" {
    for_each = lookup(var.subscription_pricing[count.index], "extension") == null ? [] : []
    content {
      name                            = lookup(extension.value, "name")
      additional_extension_properties = lookup(extension.value, "additional_extension_properties")
    }
  }
}

resource "azurerm_security_center_workspace" "this" {
  count        = length(var.log_analytics_workspace) == 0 ? 0 : length(var.workspace)
  scope        = lookup(var.workspace[count.index], "scope")
  workspace_id = try(element(module.log_analytics.workspace_id, lookup(var.workspace[count.index], "workspace_id")))
}