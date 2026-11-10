@domain:adoption @area:tool-compatibility @from:terraform-helm-scaphandre/versions
Feature: Supported tool versions
  Tells operators which Terraform/OpenTofu and provider versions the module accepts, so an unsupported toolchain is refused before anything is deployed.

  Background:
    Given the operator's root configuration calls the Scaphandre module

  @id:adoption.tool-compatibility.001 @rule:adoption.tool-compatibility.minimum-cli-version @inferred @source:versions.tf#terraform
  Scenario Outline: The module refuses a Terraform CLI older than 1.0
    Given the operator runs Terraform CLI version <cli_version>
    When the operator initialises the configuration
    Then initialisation <outcome>

    Examples:
      | cli_version    | outcome                                                                |
      | 0.15.5         | fails with an unsupported Terraform Core version error naming ">= 1.0" |
      | 1.0.0          | proceeds                                                               |
      | 1.9.8          | proceeds                                                               |
      | OpenTofu 1.6.0 | proceeds                                                               |

  @id:adoption.tool-compatibility.002 @rule:adoption.tool-compatibility.minimum-provider-versions @inferred @source:versions.tf#terraform @questionable
  Scenario Outline: The module requires Helm provider 2.0 or later and null provider 3.0 or later
    Given the operator's configuration pins the <provider> provider to version <provider_version>
    When the operator initialises the configuration
    Then initialisation <outcome>

    Examples:
      | provider       | provider_version | outcome                                                           |
      | hashicorp/helm | 1.3.2            | fails because no version satisfies ">= 2.0" together with the pin |
      | hashicorp/helm | 2.17.0           | proceeds                                                          |
      | hashicorp/helm | 3.0.2            | proceeds                                                          |
      | hashicorp/null | 2.1.2            | fails because no version satisfies ">= 3.0" together with the pin |
      | hashicorp/null | 3.2.3            | proceeds                                                          |
