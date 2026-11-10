@domain:developer-tooling @area:task-commands @from:terraform-helm-scaphandre/makefile
Feature: Running the repository's task commands
  Gives a contributor the same make verbs as every other repository in the estate, so they can set up, check and validate the module without reading the Makefile.

  Background:
    Given a contributor has a checkout of the terraform-helm-scaphandre repository

  @id:developer-tooling.task-commands.001 @rule:tooling.make.bare-make-lists-verbs @inferred @source:Makefile#help
  Scenario: Running make with no verb lists every available verb
    When the contributor runs make with no verb
    Then a list of verbs is printed, one per line, each with its one-line description
    And the list includes setup, install, lint, format, test, analyze, build and run
    And no other command is executed

  @id:developer-tooling.task-commands.002 @rule:tooling.make.not-applicable-verbs-explain-themselves @inferred @source:Makefile#build
  Scenario Outline: A verb that does not apply to a Terraform module says why and succeeds
    When the contributor runs make <verb>
    Then "<message>" is printed
    And "See README > Not applicable." is printed
    And the command exits with status 0

    Examples:
      | verb  | message                                                                  |
      | build | Nothing to build: this is a Terraform module, consumed from source.      |
      | run   | Nothing to run: a module is called by a root module, never run directly. |

  @id:developer-tooling.task-commands.003 @rule:tooling.make.analyze-refuses-without-tflint @inferred @source:Makefile#analyze
  Scenario: Static analysis is refused with a pointer to tflint when tflint is not installed
    Given tflint is not installed on the contributor's machine
    When the contributor runs make analyze
    Then "analyze needs tflint: https://github.com/terraform-linters/tflint" is printed on standard error
    And the command fails, with make reporting error 69 for the analyze step
    And no lint is performed

  @id:developer-tooling.task-commands.004 @rule:tooling.make.test-validates-module-and-example @inferred @source:Makefile#test
  Scenario: The test verb validates both the module and its example configuration
    When the contributor runs make test
    Then the module's configuration is validated without configuring a state backend
    And the example configuration under examples is validated the same way
    And the command fails if either configuration is invalid
