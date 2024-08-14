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

##