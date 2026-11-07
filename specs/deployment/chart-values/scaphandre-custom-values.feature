@domain:deployment @area:chart-values @from:terraform-helm-scaphandre/terraform-helm-scaphandre
Feature: Customising the Scaphandre deployment
  Lets the operator tune any Scaphandre chart setting without the module having to expose each one.

  Background:
    Given the operator's Terraform configuration calls the Scaphandre module

  @id:deployment.chart-values.001 @rule:scaphandre.values.passed-through @inferred @source:main.tf#helm_release.scaphandre
  Scenario Outline: Helm values the operator provides reach the Scaphandre chart unchanged
    Given the values are set to <values>
    When the operator applies the configuration
    Then the Scaphandre release is configured with <values>

    Examples:
      | values                                            |
      | { resources = { limits = { memory = "200Mi" } } } |
      | {} (the chart's defaults)                         |
