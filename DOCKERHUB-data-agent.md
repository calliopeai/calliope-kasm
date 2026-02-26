# Calliope Data Agent

AI-powered data analysis and SQL agent backend by [Calliope AI](https://calliope.ai).

## Quick Start

```bash
docker pull calliopeai/calliope-data-agent:agent-latest
```

### Run with Docker Compose

```bash
# Clone the repository
git clone https://github.com/calliopeai/jupyterlab-data-agent.git
cd jupyterlab-data-agent

# Start the agent with PostgreSQL
docker compose up -d
```

The agent API will be available at `http://localhost:5000`.

### Run Standalone

```bash
docker run --rm -it \
  -p 5000:5000 \
  -e MAIN_DB_DIALECT=sqlite \
  -e LLM_PROVIDER=ollama \
  calliopeai/calliope-data-agent:agent-latest
```

## What's Included

- **SQL Agent** - Natural language to SQL translation with multi-database support
- **RAG Engine** - Retrieval-Augmented Generation for context-aware queries
- **Multi-LLM Support** - OpenAI, Anthropic Claude, Google Gemini, AWS Bedrock, Ollama
- **Multi-Database** - PostgreSQL, MySQL, SQLite, MSSQL, Snowflake, MongoDB, and more
- **REST API** - Flask-based API for chat, SQL execution, and data analysis
- **JupyterHub Integration** - Seamless embedding in JupyterHub environments

## Tags

| Tag | Description |
|-----|-------------|
| `agent-latest` | Latest stable agent release |
| `agent-stable` | Production-ready release |

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `MAIN_DB_DIALECT` | Database backend (`postgresql` or `sqlite`) | `postgresql` |
| `LLM_PROVIDER` | AI provider (`ollama`, `openai`, `anthropic`, `gemini`, `aws`) | `ollama` |
| `SECRET_ENCRYPTION_KEY` | 32-byte hex key for encryption | Required in production |
| `AGENT_ADMIN_TOKEN` | Bearer token for admin endpoints | Required in production |
| `CORS_ORIGINS` | Allowed CORS origins | `*` |

## Architecture

```
┌─────────────────┐     ┌──────────────┐
│   Chat Studio   │────▶│  Data Agent   │
│   (Frontend)    │     │  (This Image) │
└─────────────────┘     └──────┬───────┘
                               │
                    ┌──────────┴──────────┐
                    │                     │
              ┌─────▼─────┐       ┌──────▼──────┐
              │ PostgreSQL │       │  LLM APIs   │
              │ (Metadata) │       │ (Your Keys) │
              └───────────┘       └─────────────┘
```

## Resources

- [Calliope AI](https://calliope.ai) - Main website
- [Desktop Releases](https://github.com/calliopeai/calliope-ai-desktop-releases) - Standalone downloads
- [Documentation](https://docs.calliope.ai) - Full docs
- [Discord](https://discord.gg/Z9bbbE6hJv) - Community support

## License

Calliope Data Agent is free to use. See [calliope.ai](https://calliope.ai) for terms.

---

**Built by [Calliope Labs](https://calliope.ai)**
