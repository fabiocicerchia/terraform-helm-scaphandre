# Specifications of terraform-helm-scaphandre

What this code does, one atomic Gherkin scenario per behaviour, read from the code by code-atlas.
Tags: `@verified` a test asserts it · `@inferred` read from the code only · `@gap` an entry point no test covers · `@human` written or amended by a person, never rewritten.

## Adoption and compatibility

What a consumer needs to know to use the module: supported tool versions and a working reference usage.

- **Supported tool versions**: [Supported tool versions](adoption/tool-compatibility/supported-tool-versions.feature) (2)
- **Reference example**: [Reading deployment details from the reference example](adoption/usage-example/example-deployment-outputs.feature) (1), [Running the reference example](adoption/usage-example/reference-example.feature) (1)

## Deployment

Installing Scaphandre, the power-consumption exporter, onto a Kubernetes cluster as a Helm release.

- **Custom configuration**: [Customising Scaphandre with Helm values](deployment/chart-values/custom-chart-values.feature) (1)
- **Chart version pinning**: [Pinning the Scaphandre chart version](deployment/chart-version/chart-version-pinning.feature) (1)
- **Namespace placement**: [Choosing the Scaphandre namespace](deployment/namespace/namespace-placement.feature) (1), [Placing Scaphandre in a namespace](deployment/namespace/scaphandre-namespace.feature) (1)
- **Release installation**: [Naming the Scaphandre release](deployment/release-install/release-name.feature) (1), [Installing the Scaphandre release](deployment/release-install/scaphandre-release-install.feature) (1)

## Developer tooling

The commands and quality gates maintainers use to set up, check and tidy the module.

- **Code quality checks**: [Enforcing house rules on the module's Terraform](developer-tooling/code-quality/terraform-lint-rules.feature) (2)
- **Task commands**: [Running the repository's task commands](developer-tooling/task-commands/make-task-commands.feature) (4)

## Observability integration

Making the deployed exporter's metrics consumable by Prometheus and its details available to the rest of the stack.

- **Deployment details**: [Reporting deployment details](observability/deployment-outputs/deployment-details.feature) (1)
