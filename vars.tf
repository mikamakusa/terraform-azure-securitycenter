variable "tags" {
  type    = map(string)
  default = {}
}

## DATASOURCE ##

variable "resource_group_name" {
  type = string
}

variable "storage_account_name" {
  type    = string
  default = null
}

variable "virtual_network_name" {
  type    = string
  default = null
}

variable "subnet_name" {
  type    = string
  default = null
}

variable "arc_machine_name" {
  type    = string
  default = null
}

variable "virtual_machine_name" {
  type    = string
  default = null
}

variable "virtual_machine_scale_set_name" {
  type    = string
  default = null
}

## MODULES ##

variable "log_analytics_workspace" {
  type    = any
  default = []
}

variable "iothub" {
  type    = any
  default = []
}

## SECURITY CENTER ##

variable "advanced_threat_protection" {
  type = list(object({
    id      = number
    enabled = bool
  }))
  default = []
}

variable "server_vulnerability_assessment" {
  type = list(object({
    id                 = number
    virtual_machine_id = any
    hybrid_machine_id  = any
  }))
  default = []
}

variable "security_device_group" {
  type = list(object({
    id        = number
    iothub_id = any
    name      = string
    allow_rule = optional(list(object({
      connection_from_ips_not_allowed = optional(list(string))
      connection_to_ips_not_allowed   = optional(list(string))
      local_users_not_allowed         = optional(list(string))
      processes_not_allowed           = optional(list(string))
    })))
    range_rule = optional(list(object({
      duration = string
      max      = number
      min      = number
      type     = string
    })))
  }))
  default = []

  validation {
    condition = length([
      for a in var.security_device_group : true if contains(["ActiveConnectionsNotInAllowedRange", "AmqpC2DMessagesNotInAllowedRange", "MqttC2DMessagesNotInAllowedRange", "HttpC2DMessagesNotInAllowedRange", "AmqpC2DRejectedMessagesNotInAllowedRange", "MqttC2DRejectedMessagesNotInAllowedRange", "HttpC2DRejectedMessagesNotInAllowedRange", "AmqpD2CMessagesNotInAllowedRange", "MqttD2CMessagesNotInAllowedRange", "HttpD2CMessagesNotInAllowedRange", "DirectMethodInvokesNotInAllowedRange", "FailedLocalLoginsNotInAllowedRange", "FileUploadsNotInAllowedRange", "QueuePurgesNotInAllowedRange", "TwinUpdatesNotInAllowedRange", "UnauthorizedOperationsNotInAllowedRange"], a.range_rule.type)
    ]) == length(var.security_device_group)
    error_message = "Possible Values are ActiveConnectionsNotInAllowedRange, AmqpC2DMessagesNotInAllowedRange, MqttC2DMessagesNotInAllowedRange, HttpC2DMessagesNotInAllowedRange, AmqpC2DRejectedMessagesNotInAllowedRange, MqttC2DRejectedMessagesNotInAllowedRange, HttpC2DRejectedMessagesNotInAllowedRange, AmqpD2CMessagesNotInAllowedRange, MqttD2CMessagesNotInAllowedRange, HttpD2CMessagesNotInAllowedRange, DirectMethodInvokesNotInAllowedRange, FailedLocalLoginsNotInAllowedRange, FileUploadsNotInAllowedRange, QueuePurgesNotInAllowedRange, TwinUpdatesNotInAllowedRange and UnauthorizedOperationsNotInAllowedRange."
  }
}

variable "iot_security_solution" {
  type = list(object({
    id                              = number
    display_name                    = string
    iothub_ids                      = any
    name                            = string
    enabled                         = optional(bool)
    events_to_export                = optional(set(string))
    log_analytics_workspace_id      = optional(any)
    log_unmasked_ips_enabled        = optional(bool)
    query_for_resources             = optional(string)
    query_subscription_ids          = optional(set(string))
    tags                            = optional(map(string))
    additional_workspace_id         = optional(any)
    additional_workspace_data_types = optional(list(string))
    recommendations_enabled = optional(list(object({
      acr_authentication               = optional(bool)
      agent_send_unutilized_msg        = optional(bool)
      baseline                         = optional(bool)
      edge_hub_mem_optimize            = optional(bool)
      edge_logging_option              = optional(bool)
      inconsistent_module_settings     = optional(bool)
      install_agent                    = optional(bool)
      ip_filter_deny_all               = optional(bool)
      ip_filter_permissive_rule        = optional(bool)
      open_ports                       = optional(bool)
      permissive_firewall_policy       = optional(bool)
      permissive_input_firewall_rules  = optional(bool)
      permissive_output_firewall_rules = optional(bool)
      privileged_docker_options        = optional(bool)
      shared_credentials               = optional(bool)
      vulnerable_tls_cipher_suite      = optional(bool)
    })))
  }))
  default = []

  validation {
    condition = length([
      for a in var.iot_security_solution : true if contains(["Alerts", "RawEvents"], a.additional_workspace_data_types)
    ]) == length(var.iot_security_solution)
    error_message = "Possible values are Alerts and RawEvents."
  }
}

variable "assessment_policy" {
  type = list(object({
    id                      = number
    description             = string
    display_name            = string
    severity                = optional(string)
    categories              = optional(list(string))
    implementation_effort   = optional(string)
    remediation_description = optional(string)
    threats                 = optional(list(string))
    user_impact             = optional(string)
  }))
  default = []

  validation {
    condition = length([
      for a in var.assessment_policy : true if contains(["Low", "Medium", "High"], a.severity)
    ]) == length(var.iot_security_solution)
    error_message = "Possible values are Low, Medium and High."
  }

  validation {
    condition = length([
      for b in var.assessment_policy : true if contains(["Unknown", "Compute", "Data", "IdentityAndAccess", "IoT", "Networking"], b.categories)
    ]) == length(var.iot_security_solution)
    error_message = "Possible values are Unknown, Compute, Data, IdentityAndAccess, IoT and Networking."
  }

  validation {
    condition = length([
      for c in var.assessment_policy : true if contains(["Low", "Moderate", "High"], c.implementation_effort)
    ]) == length(var.iot_security_solution)
    error_message = "Possible values are Low, Moderate and High."
  }

  validation {
    condition = length([
      for d in var.assessment_policy : true if contains(["AccountBreach", "DataExfiltration", "DataSpillage", "DenialOfService", "ElevationOfPrivilege", "MaliciousInsider", "MissingCoverage", "ThreatResistance"], d.threats)
    ]) == length(var.iot_security_solution)
    error_message = "Possible values are AccountBreach, DataExfiltration, DataSpillage, DenialOfService, ElevationOfPrivilege, MaliciousInsider, MissingCoverage and ThreatResistance."
  }

  validation {
    condition = length([
      for e in var.assessment_policy : true if contains(["Low", "Moderate", "High"], e.user_impact)
    ]) == length(var.iot_security_solution)
    error_message = "Possible values are Low, Moderate and High."
  }
}

variable "assessment" {
  type = list(object({
    id                   = number
    assessment_policy_id = any
    target_resource_id   = any
    additional_data      = optional(map(string))
    status = list(object({
      code        = string
      cause       = optional(string)
      description = optional(string)
    }))
  }))
  default = []

  validation {
    condition = length([
      for a in var.assessment : true if contains(["Healthy", "Unhealthy", "NotApplicable"], a.status.code)
    ]) == length(var.iot_security_solution)
    error_message = "Possible values are Healthy, Unhealthy and NotApplicable."
  }
}

variable "security_center_auto_provisioning" {
  type    = string
  default = null
}

variable "automation" {
  type = list(object({
    id          = number
    name        = string
    scopes      = list(string)
    description = optional(string)
    enabled     = optional(bool)
    tags        = optional(map(string))
    action = list(object({
      resource_id       = string
      type              = string
      connection_string = optional(string)
      trigger_url       = optional(string)
    }))
    source = list(object({
      event_source = string
      rule_set = list(object({
        rule = list(object({
          expected_value = string
          operator       = string
          property_path  = string
          property_type  = string
        }))
      }))
    }))
  }))
  default = []

  validation {
    condition = length([
      for a in var.automation : true if contains(["logicapp", "eventhub", "loganalytics"], a.action.type)
    ]) == length(var.iot_security_solution)
    error_message = "Must be set to one of: logicapp, eventhub or loganalytics."
  }

  validation {
    condition = length([
      for a in var.automation : true if contains(["Alerts", "Assessments", "AssessmentsSnapshot", "RegulatoryComplianceAssessment", "RegulatoryComplianceAssessmentSnapshot", "SecureScoreControls", "SecureScoreControlsSnapshot", "SecureScores", "SecureScoresSnapshot", "SubAssessments", "SubAssessmentsSnapshot"], a.source.event_source)
    ]) == length(var.iot_security_solution)
    error_message = "Must be one of Alerts, Assessments, AssessmentsSnapshot, RegulatoryComplianceAssessment, RegulatoryComplianceAssessmentSnapshot, SecureScoreControls, SecureScoreControlsSnapshot, SecureScores, SecureScoresSnapshot, SubAssessments or SubAssessmentsSnapshot."
  }

  validation {
    condition = length([
      for a in var.automation : true if contains(["Contains", "EndsWith", "Equals", "GreaterThan", "GreaterThanOrEqualTo", "LesserThan", "LesserThanOrEqualTo", "NotEquals", "StartsWith"], a.source.rule_set.rule.operator)
    ]) == length(var.iot_security_solution)
    error_message = "Must be one of: Contains, EndsWith, Equals, GreaterThan, GreaterThanOrEqualTo, LesserThan, LesserThanOrEqualTo, NotEquals, StartsWith."
  }

  validation {
    condition = length([
      for a in var.automation : true if contains(["Integer", "String", "Boolean", "Number"], a.source.rule_set.rule.property_type)
    ]) == length(var.iot_security_solution)
    error_message = "must be one of: Integer, String, Boolean or Number."
  }
}

variable "contact" {
  type = list(object({
    id                  = number
    alert_notifications = bool
    alerts_to_admins    = bool
    email               = string
    name                = optional(string)
    phone               = optional(string)
  }))
  default = []
}