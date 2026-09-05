# Terraform Module for Scaphandre

Terraform module to deploy Scaphandre (container-level power consumption monitoring) on Kubernetes using Helm.

## Why This Matters

Understanding where energy is consumed in your infrastructure is the first step toward reducing environmental impact. Without visibility into power consumption at the container and process level, optimisation efforts are essentially guesswork.

Scaphandre provides the granular metrics needed to:

- 🔍 **Identify energy-intensive workloads** running in your cluster
- 📊 **Measure actual power consumption** at container and process levels
- 🎯 **Target optimisation efforts** where they'll have the most impact
- 📈 **Track improvements** as you implement energy-saving changes
- 💡 **Make data-driven decisions** about resource allocation

By making power consumption visible and measurable, Scaphandre enables teams to optimise for energy efficiency alongside performance and cost—essential for meeting sustainability goals.

## Overview

Scaphandre provides container-level power consumption monitoring using CPU models and turbostat. It gives granular power usage data at the process and container level.

- **Container Power Metrics**: Track power consumption at container level
- **Process-level Monitoring**: Monitor individual processes
- **CPU Model Support**: Uses CPU model specifications for accurate measurements
- **Prometheus Integration**: Exports metrics for Prometheus scraping
- **Multi-node Support**: Monitors all nodes in the cluster

## Dependencies

**Important:** Scaphandre requires Prometheus to function properly. Scaphandre exports metrics to Prometheus for monitoring and visualization. Ensure you have Prometheus deployed in your cluster before deploying Scaphandre.

## Quick Start

```hcl
module "scaphandre" {
  source = "fabiocicerchia/scaphandre/helm"

  release_name    = "scaphandre"
  namespace       = "scaphandre"
}
```

## Inputs

| Name            | Description                                  | Type     | Default        | Required |
| --------------- | -------------------------------------------- | -------- | -------------- | :------: |
| `release_name`  | Helm release name for Scaphandre             | `string` | `"scaphandre"` | no       |
| `namespace`     | Kubernetes namespace for Scaphandre          | `string` | `"scaphandre"` | no       |
| `chart_version` | Helm chart version (empty string for latest) | `string` | `""`           | no       |
| `values`        | Helm values for Scaphandre deployment        | `any`    | `{}`           | no       |

## Outputs

| Name            | Description                                       |
| --------------- | ------------------------------------------------- |
| `namespace`     | Kubernetes namespace where Scaphandre is deployed |
| `release_name`  | Helm release name of Scaphandre                   |
| `chart_version` | Chart version of Scaphandre deployment            |

## Requirements

- Terraform >= 1.0 or OpenTofu >= 1.6
- Helm >= 2.0
- Kubernetes v1.24+
- kubectl configured to access your cluster
- Linux-based nodes (requires access to /proc and /sys)

## Usage

### Basic Deployment

```hcl
module "scaphandre" {
  source = "fabiocicerchia/scaphandre/helm"
}
```

### Pin Chart Version

```hcl
module "scaphandre" {
  source = "fabiocicerchia/scaphandre/helm"

  chart_version   = "0.5.0"
}
```

## Verify Deployment

```bash
# Check Scaphandre DaemonSet
kubectl get ds -n scaphandre

# View logs
kubectl logs -n scaphandre -l app=scaphandre --tail=50

# Check metrics endpoint
kubectl port-forward -n scaphandre <pod-name> 8080:8080
curl http://localhost:8080/metrics
```

## Grafana Dashboard

Scaphandre provides a Grafana dashboard for visualizing power consumption metrics. This dashboard needs to be manually imported into Grafana:

**Dashboard URL:** <https://raw.githubusercontent.com/hubblo-org/scaphandre/refs/heads/main/docs_src/tutorials/grafana-kubernetes-dashboard.json>

To import the dashboard:

1. Access your Grafana instance
1. Navigate to **Dashboards** → **Import**
1. Paste the URL above or download the JSON and upload it
1. Select your Prometheus data source
1. Click **Import**

## Supported Architectures

- x86_64 (Intel, AMD)
- ARM64 (with Linux 5.8+)
- Requires /proc and /sys filesystem access

## Resources

- [Scaphandre GitHub](https://github.com/hubblo-org/scaphandre)
- [Scaphandre Documentation](https://hubblo-org.github.io/scaphandre/)
- [Scaphandre Metrics](https://hubblo-org.github.io/scaphandre/references/metrics.html)

## Make targets

`make help` lists them. Every repository in this estate exposes the same eight
verbs, so you do not have to read a Makefile to find out how to build or test it
(FC-GEN-057).

| Verb      | What it does here                                    |
| --------- | ---------------------------------------------------- |
| `setup`   | Install the pre-commit hook                          |
| `install` | Download the providers this module pins              |
| `lint`    | `pre-commit run --all-files` — the whole gate        |
| `format`  | `terraform fmt -recursive`                           |
| `test`    | `terraform validate` on the module and every example |
| `analyze` | `tflint --recursive`                                 |

### Not applicable

Two verbs have no meaning for a Terraform module. They exit 0 and say so rather
than pretending to work (FC-GEN-058):

- `build` — nothing is compiled; the module is consumed from source.
- `run` — a module is instantiated by a root module, never executed directly.

## License

MIT
