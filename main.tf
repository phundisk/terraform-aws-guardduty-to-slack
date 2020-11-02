data "aws_partition" "guardduty_to_slack-current" {}

resource "aws_cloudwatch_event_rule" "guardduty_to_slack" {
  name        = var.cloudwatch_event_rule_name
  description = "Event rule pattern for all guardduty events"

  event_pattern = <<EOF
{
  "source": [
    "aws.guardduty"
  ],
  "detail-type": [
    "GuardDuty Finding"
  ]
}
EOF
}

resource "aws_cloudwatch_event_target" "guardduty_to_slack" {
  rule      = aws_cloudwatch_event_rule.guardduty_to_slack.name
  target_id = "SendToLambda"
  arn       = module.guardduty_to_slack.this_lambda_function_arn
}

module "guardduty_to_slack" {
  source = "terraform-aws-modules/lambda/aws"

  region                                  = var.region
  function_name                           = "guardduty_to_slack"
  description                             = "Guardduty to slack lambda"
  handler                                 = "index.handler"
  runtime                                 = "nodejs12.x"
  source_path                             = "${path.module}/lambda"
  create_current_version_allowed_triggers = false

  environment_variables = {
    slackChannel     = var.slack_channel
    webHookUrl       = var.slack_webhook
    minSeverityLevel = var.guardduty_severity_threshold
  }

  allowed_triggers = {
    EventRule = {
      principal  = "events.amazonaws.com"
      source_arn = aws_cloudwatch_event_rule.guardduty_to_slack.arn
    }
  }
}
