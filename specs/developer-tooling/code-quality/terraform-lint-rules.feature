@domain:developer-tooling @area:code-quality @from:terraform-helm-scaphandre/tflint
Feature: Enforcing house rules on the module's Terraform
  Serves the module's maintainers and consumers by refusing Terraform that leaves inputs or outputs undocumented or untyped, breaks snake_case naming, floats its tool or dependency versions, or carries dead declarations.

  Background:
    Given the maintainer has the module's Terraform sources checked out with tflint installed

  @id:developer-tooling.code-quality.001 @rule:code-quality.lint.interface-documented-and-typed @inferred @source:.tflint.hcl#rule "terraform_documented_variables"
  Scenario Outline: Undocumented, untyped, non-snake_case or unused declarations are refused
    Given the module declares <declaration> <problem>
    When the maintainer runs the code analysis
    Then the analysis fails
    And the report names the rule <lint_rule> against <declaration>

    Examples:
      | declaration                 | problem                 | lint_rule                      |
      | variable "namespace"        | without a description   | terraform_documented_variables |
      | output "chart_version"      | without a description   | terraform_documented_outputs   |
      | variable "release_name"     | without a type          | terraform_typed_variables      |
      | variable "releaseName"      | not in snake_case       | terraform_naming_convention    |
      | variable "chart_repository" | that nothing references | terraform_unused_declarations  |

  @id:developer-tooling.code-quality.003 @rule:code-quality.lint.versions-and-sources-pinned @inferred @source:.tflint.hcl#rule "terraform_module_pinned_source"
  Scenario Outline: Tool versions, provider versions and module sources must be pinned
    Given the module <problem>
    When the maintainer runs the code analysis
    Then the analysis fails
    And the report names the rule <lint_rule>

    Examples:
      | problem                                                               | lint_rule                      |
      | declares no required Terraform version                                | terraform_required_version     |
      | uses the helm provider without a version constraint                   | terraform_required_providers   |
      | calls a module from git::https://example.com/acme/mod.git with no ref | terraform_module_pinned_source |
