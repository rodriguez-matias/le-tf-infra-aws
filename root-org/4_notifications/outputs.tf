output "sns_topic_arn" {
  description = "ARN of the created SNS topic for Slack"
  value       = "${module.notify_slack.this_slack_topic_arn}"
}

output "lambda_iam_role_arn" {
  description = "The ARN of the IAM role used by Lambda function"
  value       = "${module.notify_slack.lambda_iam_role_arn}"
}

output "lambda_iam_role_name" {
  description = "The name of the IAM role used by Lambda function"
  value       = "${module.notify_slack.lambda_iam_role_name}"
}

output "notify_slack_lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = "${module.notify_slack.notify_slack_lambda_function_arn}"
}

output "notify_slack_lambda_function_invoke_arn" {
  description = "The ARN to be used for invoking Lambda function from API Gateway"
  value       = "${module.notify_slack.notify_slack_lambda_function_invoke_arn}"
}

output "notify_slack_lambda_function_last_modified" {
  description = "The date Lambda function was last modified"
  value       = "${module.notify_slack.notify_slack_lambda_function_last_modified}"
}

output "notify_slack_lambda_function_name" {
  description = "The name of the Lambda function"
  value       = "${module.notify_slack.notify_slack_lambda_function_name}"
}

output "notify_slack_lambda_function_version" {
  description = "TLatest published version of your Lambda function"
  value       = "${module.notify_slack.notify_slack_lambda_function_version}"
}
