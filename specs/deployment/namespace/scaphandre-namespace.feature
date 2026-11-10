@domain:deployment @area:namespace @from:terraform-helm-scaphandre/terraform-helm-scaphandre
Feature: Placing Scaphandre in a namespace
  Lets the operator choose where Scaphandre runs without having to create the namespace first.

  Background:
    Given the operator's Terraform configuration calls the Scaphandre module

  @id:deployment.namespace.001 @rule:scaphandre.namespace.created-if-missing @inferred @source:main.tf#helm_release.scaphandre
  Scenario Outline: Scaphandre runs in the chosen namespace, which is created when absent
    Given the namespace is set to <namespace>
    And the namespace <namespace> <exists> in the cluster
    When the operator applies the configuration
    Then the Scaphandre release is installed in namespace <namespace>
    And the namespace <namespace> exists in the cluster

    Examples:
      | namespace  | exists         |
      | scaphandre | does not exist |
      | monitoring | already exists |
