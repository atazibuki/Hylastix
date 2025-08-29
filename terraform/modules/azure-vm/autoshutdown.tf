resource "azurerm_dev_test_global_vm_shutdown_schedule" "vm_shutdown" {

  count = var.auto_shutdown_enabled ? 1 : 0
  location           = var.location
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  enabled               = true
  daily_recurrence_time = var.auto_shutdown_time
  timezone              = var.auto_shutdown_timezone

notification_settings {
    enabled         = var.auto_shutdown_notification_email != null && trim(var.auto_shutdown_notification_email) != ""
    email           = var.auto_shutdown_notification_email
    time_in_minutes = var.auto_shutdown_notification_minutes_before
  }
}