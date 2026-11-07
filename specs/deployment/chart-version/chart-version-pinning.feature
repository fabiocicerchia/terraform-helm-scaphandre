@domain:deployment @area:chart-version @from:terraform-helm-scaphandre/variables
Feature: Pinning the Scaphandre chart version
  Lets an operator pin the Scaphandre chart version for reproducible installs, or leave it unpinned.

  Background:
    Given the operator calls the Scaphandre module from a Terraform or OpenTofu configuration

  @id:deployment.chart-version.002 @rule:deployment.chart-version.empty-version-is-unpinned @inferred @source:variables.tf#chart_version @questionable
  Scenario Outline: An empty chart version installs the chart without pinning a version
    Given the operator sets the chart version input to <chart_version_input>
    When the operator applies the configuration
    Then Scaphandre is installed from <chart_selected>

    Examples:
      | chart_version_input | chart_selected                                                          |
      | nothing             | the Scaphandre chart shipped with the module, with no version requested |
      | ""                  | the Scaphandre chart shipped with the module, with no version requested |
      | "1.0.0"             | the Scaphandre chart at version 1.0.0                                   |
