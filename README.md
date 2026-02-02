# OpenClaw Docker Sandbox

This template provides an isolated environment for running OpenClaw locally in a dockerized sandbox, with local models via LM Studio.

Only tested on Mac so far...

## Getting Started

### 1. Prepare LM Studio

- Load a model (e.g., gpt-oss-20b).
- Go to the Local Server (Developer tab).
- Change Network Binding from `127.0.0.1` to your Local Network/Public IP (e.g., `192.168.x.x`).
- Enable CORS.
- Start the server.

### 2. Start the OpenClaw Gateway

- Make sure Docker Desktop is running.
- Run:

  ```sh
  chmod +x start.sh tui.sh
  ./start.sh
  ```

- This will start the OpenClaw gateway in your terminal. Leave this tab open.

### 3. Start the OpenClaw TUI (Chat Interface)

- Run `./start.sh` to boot up gateway
- Open a new terminal tab/window.
- Run:

  ```sh
  ./tui.sh
  ```

- This will connect to the running gateway and launch the chat interface.

### 4. Configure Connection (Onboarding Wizard)

- If prompted, use these values:
  - **Provider:** OpenAI-Compatible (API Key type)
  - **Base URL:** `http://host.docker.internal:1234/v1`
  - **API Key:** lm-studio
  - **Model ID:** (Enter the Identifier shown in LM Studio)

## Troubleshooting

- Gateway Status: If the TUI displays a disconnected status, run "rm .openclaw/gateway.pid" and restart the script.
- Connection: Verify that LM Studio sever (in Developer tab) is set to Public mode. Docker cannot communicate with LM Studio if it is bound only to 127.0.0.1.
- Config Validation: Run "docker compose run --rm openclaw setup" to check for syntax errors in your json file.

## LM Studio logs

Stream LM Studio logs using LM Studio CLI's built in log monitoring command:

```sh
lms log stream --source server
```
