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

- first run will trigger openclaw onboarding wizard. see openclaw.example.json for connection url, api key and model selection example if using LM Studio local model on host machine

- subsequent runs will start the OpenClaw gateway in your terminal. Leave this tab open.

- Open a new terminal tab/window.
- Run:

  ```sh
  ./tui.sh
  ```

- This will connect the openclaw TUI to the running gateway and launch the chat interface

## Troubleshooting

- Gateway Status: If the TUI displays a disconnected status, run "rm .openclaw/gateway.pid" and restart the script.
- Connection: Verify that LM Studio sever (in Developer tab) is set to Public mode. Docker cannot communicate with LM Studio if it is bound only to 127.0.0.1.
- Config Validation: Run "docker compose run --rm openclaw setup" to check for syntax errors in your json file.

## LM Studio logs

Stream LM Studio logs using LM Studio CLI's built in log monitoring command:

```sh
lms log stream --source server
```
