const http = require("http");
const { execSync } = require("child_process");

const port = 3000;

function getPortInfo() {
  try {
    const output = execSync(`netstat -ano -p tcp | findstr :${port}`, {
      encoding: "utf8",
      stdio: ["ignore", "pipe", "ignore"]
    });

    const rows = output
      .split(/\r?\n/)
      .map((line) => line.trim())
      .filter(Boolean)
      .map((line) => {
        const parts = line.split(/\s+/);
        return {
          protocol: parts[0],
          localAddress: parts[1],
          remoteAddress: parts[2],
          state: parts[3],
          pid: parts[4]
        };
      });

    return rows.filter((row) => row.localAddress.endsWith(`:${port}`));
  } catch {
    return [];
  }
}

function checkHttp() {
  return new Promise((resolve) => {
    const request = http.get(
      {
        host: "127.0.0.1",
        port,
        path: "/",
        timeout: 3000
      },
      (response) => {
        response.resume();
        resolve({ ok: true, statusCode: response.statusCode });
      }
    );

    request.on("timeout", () => {
      request.destroy(new Error("Request timed out"));
    });

    request.on("error", (error) => {
      resolve({ ok: false, message: error.message });
    });
  });
}

async function main() {
  const portInfo = getPortInfo();
  const listening = portInfo.filter((row) => row.state === "LISTENING");
  const httpResult = await checkHttp();

  if (httpResult.ok) {
    console.log(`Healthy: http://localhost:${port}/ returned ${httpResult.statusCode}.`);
    if (listening.length > 0) {
      console.log(`Listening PID(s): ${listening.map((row) => row.pid).join(", ")}`);
    }
    process.exit(0);
  }

  if (listening.length > 0) {
    console.log(`Stale server suspected: port ${port} is listening, but HTTP failed.`);
    console.log(`Listening PID(s): ${listening.map((row) => row.pid).join(", ")}`);
    console.log(`HTTP error: ${httpResult.message}`);
    console.log("Recommended fix: npm run dev:reset");
    process.exit(1);
  }

  if (portInfo.length > 0) {
    console.log(`Port ${port} has TCP activity but no listener is healthy yet.`);
    console.log(`HTTP error: ${httpResult.message}`);
    console.log("Recommended fix: wait a few seconds, then rerun this check.");
    process.exit(1);
  }

  console.log(`No dev server detected on port ${port}.`);
  console.log("Recommended fix: npm run dev or npm run dev:reset");
  process.exit(1);
}

main();
