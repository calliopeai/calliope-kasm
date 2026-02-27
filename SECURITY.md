# Security Policy

## Supported Versions

We provide security updates for the latest release of each product image:

| Product | Image | Supported |
|---------|-------|-----------|
| Calliope AI IDE | `calliope-ide-4kasm:latest` | Yes |
| Calliope AI Lab | `calliope-lab-4kasm:latest` | Yes |
| Chat Studio | `calliope-chat-studio-kasm:latest` | Yes |
| Loadr | `calliope-loadr-kasm:latest` | Yes |

Older tagged versions do not receive retroactive security patches. We recommend always running the `latest` tag.

## Reporting a Vulnerability

If you discover a security vulnerability in this project, please report it responsibly.

**Email:** security@calliope.ai

Please include:

- Description of the vulnerability
- Steps to reproduce
- Affected product(s) and version(s)
- Any potential impact assessment

## Response Timeline

- **Acknowledgment**: Within 48 hours of report
- **Assessment**: Within 7 days
- **Fix or mitigation**: Depends on severity, but we aim for 30 days for critical issues

## Scope

This policy covers the Dockerfiles, build scripts, and installation scripts in this repository. For vulnerabilities in the Calliope AI applications themselves, please report to security@calliope.ai as well.

Issues in the upstream [Kasm base image](https://hub.docker.com/r/kasmweb/core-debian-bookworm) should be reported directly to [Kasm Technologies](https://kasmweb.com).
