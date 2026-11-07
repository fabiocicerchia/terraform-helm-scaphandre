@domain:observability @area:deployment-outputs @from:terraform-helm-scaphandre/outputs
Feature: Reporting deployment details
  Calling configurations can read where Scaphandre was deployed, under which release name and at which chart version, so they can wire monitoring and other resources to it.

  Background:
    Given the operator's configuration calls the Scaphandre module

  @id:observability.deployment-outputs.001 @rule:scaphandre.outputs.reports-namespace-and-release-name @inferred @source:outputs.tf#namespace
  Scenario Outline: The deployment reports the namespace and release name it was installed under
    Given the operator sets the namespace to "<namespace>"
    And the operator sets the release name to "<release_name>"
    When the operator applies the configuration
    Then the "namespace" output is "<namespace>"
    And the "release_name" output is "<release_name>"

    Examples:
      | namespace         | release_name    |
      | scaphandre        | scaphandre      |
      | energy-monitoring | scaphandre-prod |

  @id:observability.deployment-outputs.002 @rule:scaphandre.outputs.reports-chart-version @inferred @source:outputs.tf#chart_version
  Scenario Outline: The deployment reports the chart version it installed
    Given the operator sets the chart version to "<chart_version>"
    When the operator applies the configuration
    Then the "chart_version" output is <reported>

    Examples:
      | chart_version | reported                                            |
      | 1.0.2         | "1.0.2"                                             |
      |               | the version of the bundled chart that was installed |
