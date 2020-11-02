# terraform-aws-guardduty-to-slack
This will spin up the required AWS resources to be able to grab events from AWS GuardDuty and send them to Slack formatted.  This is based off the based off of this cloudformation template created by AWS here: https://github.com/aws-samples/amazon-guardduty-to-slack

## Requirements
This will not create guardduty for you.  You need to have that running for this to be able to pull guardduty events.

## Usage
```
module "gd_alert" {
  source = "github.com/phundisk/terraform-aws-guardduty-to-slack"
  slack_webhook = "https://hooks.slack.com/services/XXXX"
  slack_channel = "guardduty-channel"
  region = "us-east-1"
}
```

