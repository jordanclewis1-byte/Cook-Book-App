const { existsSync, rmSync } = require("fs");
const { join } = require("path");
const { execSync, spawn } = require("child_process");

const projectRoot = process.cwd();
const nextDir = join(projectRoot, ".next");

function findPort3000Pids() {
  try {
    const output = execSync("netstat -ano -p tcp", {
      cwd: projectRoot,
      encoding: "utf8",
      stdio: ["ignore", "pipe", "ignore"]
    });

    return Array.from(
      new Set(
        output
          .split(/\r?\n/)
          .filter((line) => line.includes(":3000"))
          .filter((line) => /\bLISTENING\b/.test(line) || /\bESTABLISHED\b/.test(line))
          .map((line) => line.trim().split(/\s+/).pop())
          .filter(Boolean)
      )
    );
  } catch {
    return [];
  }
}

function killProcesses(pids) {
  for (const pid of pids) {
    try {
      execSync(`taskkill /PID ${pid} /F`, {
        cwd: projectRoot,
        stdio: ["ignore", "ignore", "ignore"]
      });
      console.log(`Stopped process on port 3000: ${pid}`);
    } catch {
      console.log(`Could not stop process ${pid}, continuing.`);
    }
  }
}

function clearNextBuildOutput() {
  if (!existsSync(nextDir)) {
    return;
  }

  rmSync(nextDir, { recursive: true, force: true });
  console.log("Cleared .next build output.");
}

function startNextDev() {
  const nextBin = require.resolve("next/dist/bin/next");
  const child = spawn(process.execPath, [nextBin, "dev"], {
    cwd: projectRoot,
    stdio: "inherit"
  });

  child.on("exit", (code) => {
    process.exit(code ?? 0);
  });
}

killProcesses(findPort3000Pids());
clearNextBuildOutput();
startNextDev();
