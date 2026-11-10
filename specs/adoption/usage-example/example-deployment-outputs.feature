@domain:adoption @area:usage-example @from:examples/outputs
Feature: Reading deployment details from the reference example
  Operators who copy the reference example get the deployed Scaphandre's namespace, release name and chart version as root outputs, so they can wire them into other configurations without reaching into the module.

  Background:
    Given the operator has applied the reference example, which deploys Scaphandre as release "scaphandre" in namespace "scaphandre-system" with no pinned chart version

  @id:adoption.usage-example.003 @rule:adoption.usage-example.reexposes-deployment-details @inferred @source:examples/outputs.tf#scaphandre_namespace
  Scenario Outline: The reference example reports the deployed Scaphandre's namespace, release name and chart version
    Given the Scaphandre release is deployed
    When the operator reads the example's <output> output
    Then the value is <value>
    And it matches the module's <module_output> output

    Examples:
      | output                   | value                                     | module_output |
      | scaphandre_namespace     | scaphandre-system                         | namespace     |
      | scaphandre_release_name  | scaphandre                                | release_name  |
      | scaphandre_chart_version | the chart version Helm actually installed | chart_version |
