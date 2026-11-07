@domain:deployment @area:release-install @from:terraform-helm-scaphandre/variables
Feature: Naming the Scaphandre release
  Lets an operator choose the Helm release name Scaphandre is installed under, so several installs or naming conventions can coexist, with a sensible default.

  Background:
    Given the operator calls the Scaphandre module from a Terraform or OpenTofu configuration

  @id:deployment.release-install.003 @rule:deployment.release-install.release-name-defaults-to-scaphandre @inferred @source:variables.tf#release_name
  Scenario Outline: The release is named scaphandre unless the operator names it
    Given the operator sets the release name input to <release_name_input>
    When the operator applies the configuration
    Then the Scaphandre Helm release is named "<release_name>"
    And the module reports the release name "<release_name>"

    Examples:
      | release_name_input | release_name    |
      | nothing            | scaphandre      |
      | "carbon-exporter"  | carbon-exporter |
