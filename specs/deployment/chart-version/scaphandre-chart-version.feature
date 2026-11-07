@domain:deployment @area:chart-version @from:terraform-helm-scaphandre/terraform-helm-scaphandre
Feature: Pinning the Scaphandre chart version
  Lets the operator lock Scaphandre to a known chart version, or leave it unpinned.

  Background:
    Given the operator's Terraform configuration calls the Scaphandre module

  @id:deployment.chart-version.001 @rule:scaphandre.chart-version.pinned-or-unpinned @inferred @source:main.tf#helm_release.scaphandre @questionable
  Scenario Outline: A chart version is pinned when given, and left open when empty
    Given the chart version is set to "<chart_version>"
    When the operator applies the configuration
    Then the release asks for chart version <requested>

    Examples:
      | chart_version | requested                                           |
      | 0.5.0         | 0.5.0                                               |
      |               | no specific version (the vendored chart as shipped) |
