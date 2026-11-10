@domain:deployment @area:namespace @from:terraform-helm-scaphandre/variables
Feature: Choosing the Scaphandre namespace
  Lets an operator place Scaphandre in the Kubernetes namespace of their choice, defaulting to a dedicated scaphandre namespace.

  Background:
    Given the operator calls the Scaphandre module from a Terraform or OpenTofu configuration

  @id:deployment.namespace.002 @rule:deployment.namespace.namespace-defaults-to-scaphandre @inferred @source:variables.tf#namespace
  Scenario Outline: Scaphandre runs in the scaphandre namespace unless the operator picks another
    Given the operator sets the namespace input to <namespace_input>
    When the operator applies the configuration
    Then Scaphandre is installed in the Kubernetes namespace "<namespace>"
    And the module reports the namespace "<namespace>"

    Examples:
      | namespace_input | namespace  |
      | nothing         | scaphandre |
      | "monitoring"    | monitoring |
