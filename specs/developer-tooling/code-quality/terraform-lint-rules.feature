@domain:developer-tooling @area:code-quality @from:terraform-helm-scaphandre/tflint
Feature: Enforcing house rules on the module's Terraform
  Serves the module's maintainers and consumers by refusing Terraform that leaves inputs or outputs undocumented or untyped, breaks snake_case naming, floats its tool or dependency versions, or carries dead declarations.

  Background:
    Given the maintainer has the module's Terraform sources checked out with tflint installed

  @id:developer-tooling.code-quality.001 @rule:code-quality.lint.interface-documented-and-typed @inferred @source:.tflint.hcl#rule "terraform_documented_variables"
  Scenario Outline: Every module input and output must be described, and every input typed
    Given the module declares <declaration> <problem>
    When the maintainer runs the code analysis
    Then the analysis fails
    And the report names the rule <lint_rule> against <declaration>

    Examples:
      | declaration             | problem               | lint_rule                      |
      | variable "namespace"    | without a description | terraform_documented_variables |
      | output "chart_version"  | without a description | terraform_documented_outputs   |
      | variable "release_name" | without a type        | terraform_typed_variables      |

  @id:developer-tooling.code-quality.002 @rule:code-quality.lint.snake-case-names @inferred @source:.tflint.hcl#rule "terraform_naming_convention"
  Scenario: Names that are not snake_case are refused
    Given the module declares a variable named "releaseName"
    When the maintainer runs the code analysis
    Then the analysis fails
    And the report names the rule terraform_naming_convention and asks for snake_case

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

  @id:developer-tooling.code-quality.004 @rule:code-quality.lint.no-unused-declarations @inferred @source:.tflint.hcl#rule "terraform_unused_declarations"
  Scenario: Declared but unused variables, locals and data sources are refused
    Given the module declares a variable "chart_repository" that nothing references
    When the maintainer runs the code analysis
    Then the analysis fails
    And the report names the rule terraform_unused_declarations against variable "chart_repository"
