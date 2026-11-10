@domain:observability @area:deployment-outputs @from:terraform-helm-scaphandre/outputs
Feature: Reporting deployment details
  Calling configurations can read where Scaphandre was deployed, under which release name and at which chart version, so they can wire monitoring and other resources to it.

  Background:
    Given the operator's configuration calls the Scaphandre module

  @id:observability.deployment-outputs.002 @rule:scaphandre.outputs.reports-chart-version @inferred @source:outputs.tf#chart_version
  Scenario Outline: The deployment reports the chart version it installed
    Given the operator sets the chart version to "<chart_version>"
    When the operator applies the configuration
    Then the "chart_version" output is <reported>

    Examples:
      | chart_version | reported                                            |
      | 1.0.2         | "1.0.2"                                             |
      |               | the version of the bundled chart that was installed |
