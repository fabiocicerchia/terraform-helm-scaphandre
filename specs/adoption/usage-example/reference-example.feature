@domain:adoption @area:usage-example @from:examples/examples
Feature: Running the reference example
  Gives operators evaluating the module a runnable root configuration that deploys Scaphandre with typical settings and shows them where it landed.

  Background:
    Given the operator has a Kubernetes cluster reachable by Helm
    And the operator runs the reference example root configuration

  @id:adoption.usage-example.002 @rule:adoption.usage-example.requires-helm-provider-2x @inferred @source:examples/main.tf#terraform @questionable
  Scenario Outline: The reference example only runs with Terraform 1.0 or newer and a Helm provider in the 2.x line
    Given the operator's tooling is <terraform> with Helm provider <helm_provider>
    When the operator initialises the reference example
    Then initialisation is <result>

    Examples:
      | terraform      | helm_provider | result                                           |
      | Terraform 1.5  | 2.12          | accepted                                         |
      | Terraform 1.5  | 3.0           | refused with a provider version constraint error |
      | Terraform 0.15 | 2.12          | refused with a required version error            |
