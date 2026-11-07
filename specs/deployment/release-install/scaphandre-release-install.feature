@domain:deployment @area:release-install @from:terraform-helm-scaphandre/terraform-helm-scaphandre
Feature: Installing the Scaphandre release
  Lets a platform operator put Scaphandre power monitoring on a cluster as a single Helm release with a name they choose.

  Background:
    Given the operator's Terraform configuration calls the Scaphandre module
    And the cluster is reachable with the operator's Helm credentials

  @id:deployment.release-install.001 @rule:scaphandre.release.installed-under-configured-name @inferred @source:main.tf#helm_release.scaphandre
  Scenario Outline: Scaphandre is installed as a Helm release under the chosen release name
    Given the release name is set to <release_name>
    When the operator applies the configuration
    Then a Helm release named <release_name> exists
    And the release is installed from the Scaphandre chart that ships with the module

    Examples:
      | release_name   |
      | scaphandre     |
      | energy-monitor |

  @id:deployment.release-install.002 @rule:scaphandre.release.replaces-existing-release @inferred @source:main.tf#helm_release.scaphandre @questionable
  Scenario: A failed release with the same name is replaced, not refused
    Given an earlier install of a Helm release named "scaphandre" in the target namespace failed and Terraform does not manage it
    When the operator applies the configuration
    Then the apply does not fail with a name conflict
    And the "scaphandre" release now runs the module's chart and values
