## ADVANCED THREAT PROTECTION ##

output "advanced_threat_protection_id" {
  value = try(
    azurerm_advanced_threat_protection.this.*.id
  )
}

## SERVER VULNERABILITY ASSESSMENT ##

output "server_vulnerability_assessment_id" {
  value = try(
    azurerm_security_center_server_vulnerability_assessment.this.*.id
  )
}

## IOT SECURITY DEVICE GROUP ##

output "iot_security_device_group_id" {
  value = try(
    azurerm_iot_security_device_group.this.*.id
  )
}

output "iot_security_device_group_name" {
  value = try(
    azurerm_iot_security_device_group.this.*.name
  )
}

## IOT SECURITY SOLUTION ##

output "iot_security_solution_id" {
  value = try(
    azurerm_iot_security_solution.this.*.id
  )
}

output "iot_security_solution_name" {
  value = try(
    azurerm_iot_security_solution.this.*.name
  )
}

## ASSESSMENT POLICY ##

output "assessment_policy_id" {
  value = try(
    azurerm_security_center_assessment_policy.this.*.id
  )
}

output "assessment_policy_name" {
  value = try(
    azurerm_security_center_assessment_policy.this.*.name
  )
}

## ASSESSMENT ##

output "assessment_id" {
  value = try(
    azurerm_security_center_assessment.this.*.id
  )
}

## AUTO PROVISIONING ##

output "auto_provisioning_id" {
  value = try(
    azurerm_security_center_auto_provisioning.this.*.id
  )
}

## AUTOMATION ##

output "automation_id" {
  value = try(
    azurerm_security_center_automation.this.*.id
  )
}

output "automation_name" {
  value = try(
    azurerm_security_center_automation.this.*.name
  )
}

## CONTACT ##

output "contact_id" {
  value = try(
    azurerm_security_center_contact.this.*.id
  )
}

output "contact_name" {
  value = try(
    azurerm_security_center_contact.this.*.name
  )
}

## SERVER VULNERABILITY ASSESSMENT VIRTUAL MACHINE

output "server_vulnerability_assessment_virtual_machine_id" {
  value = try(
    azurerm_security_center_server_vulnerability_assessment_virtual_machine.this.*.id
  )
}

## SERVER VULNERABILITY ASSESSMENT

output "server_vulnerability_assessments_setting_name" {
  value = try(
    azurerm_security_center_server_vulnerability_assessments_setting.name
  )
}

## SETTING ##

output "setting_id" {
  value = try(
    azurerm_security_center_setting.this.*.id
  )
}

output "setting_name" {
  value = try(
    azurerm_security_center_setting.this.*.setting_name
  )
}

## STORAGE DEFENDER ##

output "storage_defender_id" {
  value = try(
    azurerm_security_center_storage_defender.this.*.id
  )
}

## SUBSCRIPTION PRICING ##

output "security_center_subscription_pricing_id" {
  value = try(
    azurerm_security_center_subscription_pricing.this.*.id
  )
}

## LOG ANALYTICS SECURITY CENTER WORKSPACE ##

output "security_center_workspace_id" {
  value = try(
    azurerm_security_center_workspace.this.*.id
  )
}