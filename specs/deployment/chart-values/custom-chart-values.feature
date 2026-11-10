@domain:deployment @area:chart-values @from:terraform-helm-scaphandre/variables
Feature: Customising Scaphandre with Helm values
  Lets an operator tune the Scaphandre deployment by passing any Helm values through the module unchanged.

  Background:
    Given the operator calls the Scaphandre module from a Terraform or OpenTofu configuration

  @id:deployment.chart-values.002 @rule:deployment.chart-values.values-passed-through @inferred @source:variables.tf#values
  Scenario Outline: Helm values given by the operator reach the Scaphandre chart unchanged
    Given the operator sets the values input to <values>
    When the operator applies the configuration
    Then the Scaphandre release is installed with the Helm values <applied_values>

    Examples:
      | values                                  | applied_values               |
      | nothing                                 | of the chart defaults only   |
      | { serviceMonitor = { enabled = true } } | serviceMonitor.enabled: true |
