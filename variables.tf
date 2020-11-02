variable "slack_webhook" {
  description = "Slack webhook to send as"
}

variable "slack_channel" {
  description = "Slack channel to send guardduty message to"
}

variable "region" {
  description = "The region of AWS you want to work in such as us-east-1 or us-west-1"
}

variable "guardduty_severity_threshold" {
  default     = "MEDIUM"
  description = "The minimum guardduty severity threshold to send to slack.  Valid values are LOW, MEDIUM, HIGH."
}

variable "lambda_role_name" {
  default     = "guardduty_to_slack"
  description = "The role name to create for the guardduty to slack lambda to utilize"
}

variable "cloudwatch_event_rule_name" {
  default = "guardduty_alerts"
}
