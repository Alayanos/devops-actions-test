# 🧪 GitHub Actions PoC — Centralized Workflow Testing

This repository was created to test and validate the reusable GitHub Actions workflows from [`devops-actions-poc`](https://github.com/Alayanos/devops-actions-poc) before rolling them out across the organization.

---

## 🧩 Purpose

To ensure that all centralized CI/CD workflows:
- Work as expected in a real repo
- Handle releases, testing, linting, and Docker builds securely
- Can be reused by other services with minimal setup

---

## 🧪 Workflows Tested

| File           | Reused From                                | Purpose                                  |
|----------------|---------------------------------------------|-------------------------------------------|
| `lint.yml`     | `devops-actions-poc/lint-golangci.yml`      | Linting Go code using golangci-lint       |
| `test.yml`     | `devops-actions-poc/test-go.yml`            | Running `go test`                         |
| `trivy.yml`    | `devops-actions-poc/trivy.yml`              | Trivy vulnerability scan                  |
| `release.yml`  | `devops-actions-poc/release.yml`            | Git tagging → Docker build → GCR push → Slack alert |

---

## 🐳 Docker Setup

- Multi-stage Dockerfile builds the service using `make`.
- The image is tagged from the Git tag (e.g. `v1.2.3`) and pushed to:
