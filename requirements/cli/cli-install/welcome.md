## 1. CLI Install Requirements Document

### Overview

#### Tech Stack
- **Programming Language:** Python

#### Project Structure
- All classes must be under the `sdk` folder.
- The program starts from **main.py**.

#### Command Line Arguments

| Argument         | Description                                                        | Type                | Default       |
| ---------------- | ------------------------------------------------------------------ | ------------------- | ------------- |
| `--folders`      | Optional comma-separated list of JSON Task folder paths to install | String (comma list) | None          |
| `--files`        | Optional comma-separated list of JSON Task file paths to install   | String (comma list) | None          |
| `--thread-count` | Optional number of threads to execute tasks                        | Integer             | 1             |
| `--git-root`     | Optional path of git root folder                                   | String              | C:\zawjen\git |

#### Class Design and Feature Details

- **CliArgs**  
  A command line argument parser that uses the above arguments.

- **TaskManager**  
  Iterates over the list of folders and files. It creates `--thread-count` number of threads for the **TaskRunner** by passing it each task file name. If not specified, one thread is used by default.

- **Logger**  
  Provides a method `log(self, message, start_time)` that logs important or long-running steps by calculating time spent.

- **TaskRunner**  
  Reads a JSON file containing an array of tasks and executes each one by invoking the proper Task class.

- **Task (Base Class)** and **Task Types**  
  Each task is defined by a `type` attribute which could be:  
  - **install**: Download and run an installer (exe, msi, etc.).  
  - **git**: Execute a git pull (or clone if missing) for the repo specified in the `url` attribute to the location defined by `--git-root`.  
  - **command**: Run a specified PowerShell, batch, or bash command using the attribute `command`.  
  - **script**: Execute a file (absolute or relative) provided in the `path` attribute.

#### Additional Requirements

- Follow Zawjen.net coding conventions and clean coding principles.
- Use try-catch blocks to handle and log errors.
- The solution must be highly performant (low on memory, CPU, and battery), scalable, and maintainable.
- Refer to the [Zawjen.net Data Dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md) for additional definitions.
- Write complete unit tests (100% test coverage) using pytest.

---

## 2. Implementation Code

Below are the code files. (Create the directory structure as shown: a `sdk` folder for the classes and a `main.py` at the root.)

### File: main.py

```python
#!/usr/bin/env python
import sys
from sdk.cli_args import CliArgs
from sdk.logger import Logger
from sdk.task_manager import TaskManager
from sdk.task_runner import TaskRunner

def main():
    # Parse CLI arguments
    cli_args = CliArgs()
    args = cli_args.parse_args()

    # Initialize Logger
    logger = Logger()

    # Create TaskRunner instance; pass git_root from args
    task_runner = TaskRunner(logger, args.git_root)

    # Get list of folders and files from CLI arguments
    folders = CliArgs.get_folders(args)
    files = CliArgs.get_files(args)

    # Create and run TaskManager
    task_manager = TaskManager(folders, files, args.thread_count, task_runner, logger)
    task_manager.run()

if __name__ == '__main__':
    try:
        main()
    except Exception as e:
        print(f'Fatal error: {e}', file=sys.stderr)
```

---

### File: sdk/cli_args.py

```python
import argparse

class CliArgs:
    """
    CLI Arguments parser for the CLI Install Tool.
    """
    def __init__(self):
        self.parser = argparse.ArgumentParser(description="CLI Install Tool")
        self.parser.add_argument('--folders', type=str, help='Comma-separated list of JSON Task folder paths to install')
        self.parser.add_argument('--files', type=str, help='Comma-separated list of JSON Task file paths to install')
        self.parser.add_argument('--thread-count', type=int, default=1, help='Number of threads to execute tasks')
        self.parser.add_argument('--git-root', type=str, default=r'C:\zawjen\git', help='Path of git root folder')

    def parse_args(self):
        return self.parser.parse_args()

    @staticmethod
    def get_folders(args):
        if args.folders:
            return [folder.strip() for folder in args.folders.split(',')]
        return []

    @staticmethod
    def get_files(args):
        if args.files:
            return [file.strip() for file in args.files.split(',')]
        return []
```

---

### File: sdk/logger.py

```python
import time

class Logger:
    """
    Logger class for logging important or long-running steps.
    """
    def log(self, message, start_time):
        try:
            time_spent = time.time() - start_time
            print(f"{message} - Time spent: {time_spent:.2f} seconds")
        except Exception as e:
            print(f"Logging failed: {e}")
```

---

### File: sdk/task_manager.py

```python
import threading
import os

class TaskManager:
    """
    TaskManager iterates over lists of folders and files and creates threads for TaskRunner.
    """
    def __init__(self, folders, files, thread_count, task_runner, logger):
        self.folders = folders
        self.files = files
        self.thread_count = thread_count if thread_count > 0 else 1
        self.task_runner = task_runner
        self.logger = logger

    def run(self):
        tasks = []
        # Add all JSON files from provided folders
        for folder in self.folders:
            try:
                for file in os.listdir(folder):
                    if file.endswith('.json'):
                        tasks.append(os.path.join(folder, file))
            except Exception as e:
                self.logger.log(f"Error reading folder {folder}: {e}", 0)
        # Add files provided directly via CLI
        tasks.extend(self.files)
        
        if not tasks:
            self.logger.log("No tasks to run", 0)
            return
        
        threads = []
        # Limit thread count to number of tasks if there are fewer tasks than requested threads
        num_threads = min(self.thread_count, len(tasks))
        # Distribute tasks round-robin among threads
        for i in range(num_threads):
            thread_tasks = tasks[i::num_threads]
            thread = threading.Thread(target=self._run_tasks, args=(thread_tasks,))
            threads.append(thread)
            thread.start()
        
        for thread in threads:
            thread.join()

    def _run_tasks(self, tasks):
        for task_file in tasks:
            try:
                self.task_runner.run_task(task_file)
            except Exception as e:
                self.logger.log(f"Error running task file {task_file}: {e}", 0)
```

---

### File: sdk/task_runner.py

```python
import json
from sdk.task import TaskInstall, TaskGit, TaskCommand, TaskScript

class TaskRunner:
    """
    TaskRunner reads a JSON task file and executes each task based on its type.
    """
    def __init__(self, logger, git_root):
        self.logger = logger
        self.git_root = git_root

    def run_task(self, file_path):
        try:
            with open(file_path, 'r') as f:
                tasks = json.load(f)
        except Exception as e:
            self.logger.log(f"Failed to read {file_path}: {e}", 0)
            return
        
        for task in tasks:
            self.execute_task(task)

    def execute_task(self, task):
        task_type = task.get('type')
        try:
            if task_type == 'install':
                TaskInstall().execute(task)
            elif task_type == 'git':
                # Pass git_root to TaskGit for repository operations
                TaskGit(self.git_root).execute(task)
            elif task_type == 'command':
                TaskCommand().execute(task)
            elif task_type == 'script':
                TaskScript().execute(task)
            else:
                self.logger.log(f"Unknown task type: {task_type}", 0)
        except Exception as e:
            self.logger.log(f"Error executing task {task}: {e}", 0)
```

---

### File: sdk/task.py

```python
import os
import subprocess

class Task:
    """
    Base Task class. Derived tasks should implement the execute method.
    """
    def execute(self, task):
        raise NotImplementedError("Subclasses must implement this method.")

class TaskInstall(Task):
    """
    TaskInstall downloads the specified exe, msi, etc. and runs it to install.
    """
    def execute(self, task):
        try:
            url = task.get('url')
            if not url:
                raise ValueError("No URL provided for install task")
            # Download the file using curl (or another downloader in a real implementation)
            download_cmd = f"curl -O {url}"
            os.system(download_cmd)
            # Extract the filename and execute it to perform installation
            filename = url.split('/')[-1]
            os.system(filename)
        except Exception as e:
            print(f"TaskInstall error: {e}")

class TaskGit(Task):
    """
    TaskGit performs a git pull for the specified repository.
    """
    def __init__(self, git_root):
        self.git_root = git_root

    def execute(self, task):
        try:
            repo_url = task.get('url')
            if not repo_url:
                raise ValueError("No repository URL provided for git task")
            repo_name = repo_url.split('/')[-1].replace('.git', '')
            destination = os.path.join(self.git_root, repo_name)
            if not os.path.exists(destination):
                os.system(f"git clone {repo_url} {destination}")
            else:
                # Change directory and perform git pull
                os.chdir(destination)
                os.system("git pull")
        except Exception as e:
            print(f"TaskGit error: {e}")

class TaskCommand(Task):
    """
    TaskCommand runs a specified command (PowerShell, batch, or bash) as provided in the 'command' attribute.
    """
    def execute(self, task):
        try:
            command = task.get('command')
            if not command:
                raise ValueError("No command provided for command task")
            subprocess.run(command, shell=True, check=True)
        except subprocess.CalledProcessError as cpe:
            print(f"TaskCommand subprocess error: {cpe}")
        except Exception as e:
            print(f"TaskCommand error: {e}")

class TaskScript(Task):
    """
    TaskScript executes a script file provided in the 'path' attribute.
    """
    def execute(self, task):
        try:
            path = task.get('path')
            if not path:
                raise ValueError("No path provided for script task")
            subprocess.run(path, shell=True, check=True)
        except subprocess.CalledProcessError as cpe:
            print(f"TaskScript subprocess error: {cpe}")
        except Exception as e:
            print(f"TaskScript error: {e}")
```

---

## 3. Unit Tests using pytest

Below are the unit tests (assume these are placed in a `tests` folder):

### File: tests/test_cli_args.py

```python
import sys
from sdk.cli_args import CliArgs

def test_cli_args_parsing(monkeypatch):
    test_args = ['prog', '--folders', 'folder1,folder2', '--files', 'file1.json,file2.json', '--thread-count', '4', '--git-root', 'C:\\test\\git']
    monkeypatch.setattr(sys, 'argv', test_args)
    cli = CliArgs()
    args = cli.parse_args()
    assert args.folders == 'folder1,folder2'
    assert args.files == 'file1.json,file2.json'
    assert args.thread_count == 4
    assert args.git_root == r'C:\test\git'
    
def test_get_folders_and_files():
    class Args:
        folders = 'folder1,folder2'
        files = 'file1.json,file2.json'
    args = Args()
    folders = CliArgs.get_folders(args)
    files = CliArgs.get_files(args)
    assert folders == ['folder1', 'folder2']
    assert files == ['file1.json', 'file2.json']
```

---

### File: tests/test_logger.py

```python
import time
from sdk.logger import Logger

def test_logger(monkeypatch):
    logger = Logger()
    messages = []
    def fake_print(msg):
        messages.append(msg)
    monkeypatch.setattr("builtins.print", fake_print)
    start_time = time.time()
    logger.log("Test message", start_time)
    assert any("Test message" in m for m in messages)
```

---

### File: tests/test_task_runner.py

```python
import json
import tempfile
from sdk.task_runner import TaskRunner
from sdk.logger import Logger

def dummy_execute(self, task):
    print(f"Executing {task.get('type')}")

def test_run_task(tmp_path, monkeypatch):
    # Create a temporary JSON file with a list of tasks
    tasks = [
        {"type": "install", "url": "http://example.com/file.exe"},
        {"type": "git", "url": "http://example.com/repo.git"},
        {"type": "command", "command": "echo test"},
        {"type": "script", "path": "echo script"}
    ]
    task_file = tmp_path / "test_tasks.json"
    task_file.write_text(json.dumps(tasks))

    # Monkey-patch the execution methods of each Task type so no real command is run.
    monkeypatch.setattr("sdk.task.TaskInstall.execute", dummy_execute)
    monkeypatch.setattr("sdk.task.TaskGit.execute", dummy_execute)
    monkeypatch.setattr("sdk.task.TaskCommand.execute", dummy_execute)
    monkeypatch.setattr("sdk.task.TaskScript.execute", dummy_execute)

    logger = Logger()
    task_runner = TaskRunner(logger, "dummy_git_root")
    outputs = []
    monkeypatch.setattr("builtins.print", lambda s: outputs.append(s))
    task_runner.run_task(str(task_file))

    # Verify that each task type was "executed" (printed) at least once.
    assert any("Executing install" in out for out in outputs)
    assert any("Executing git" in out for out in outputs)
    assert any("Executing command" in out for out in outputs)
    assert any("Executing script" in out for out in outputs)
```

---

### File: tests/test_task_manager.py

```python
import os
import json
from sdk.task_manager import TaskManager
from sdk.logger import Logger

class DummyTaskRunner:
    def run_task(self, file_path):
        print(f"Running task file: {file_path}")

def test_task_manager(tmp_path, monkeypatch):
    # Create temporary folder with one JSON file containing a dummy task.
    task_folder = tmp_path / "tasks"
    task_folder.mkdir()
    task_file = task_folder / "task1.json"
    task_file.write_text(json.dumps([{"type": "command", "command": "echo test"}]))

    folders = [str(task_folder)]
    files = []
    logger = Logger()
    task_runner = DummyTaskRunner()

    outputs = []
    monkeypatch.setattr("builtins.print", lambda s: outputs.append(s))
    tm = TaskManager(folders, files, 2, task_runner, logger)
    tm.run()

    assert any("Running task file:" in out for out in outputs)
```

---

### File: tests/test_task.py

```python
import os
import subprocess
from sdk.task import TaskInstall, TaskGit, TaskCommand, TaskScript

def test_task_install(monkeypatch):
    executed = []
    def fake_system(cmd):
        executed.append(cmd)
        return 0
    monkeypatch.setattr(os, "system", fake_system)
    task = {"url": "http://example.com/installer.exe"}
    TaskInstall().execute(task)
    # Check that both the download and execution commands were issued
    assert any("curl -O" in cmd for cmd in executed)
    assert any("installer.exe" in cmd for cmd in executed)

def test_task_git(monkeypatch, tmp_path):
    executed = []
    def fake_system(cmd):
        executed.append(cmd)
        return 0
    monkeypatch.setattr(os, "system", fake_system)
    # Simulate os.path.exists to always return False so that git clone is used
    monkeypatch.setattr(os.path, "exists", lambda p: False)
    task = {"url": "http://example.com/repo.git"}
    git_root = str(tmp_path / "git")
    from sdk.task import TaskGit
    TaskGit(git_root).execute(task)
    assert any("git clone" in cmd for cmd in executed)

def test_task_command(monkeypatch):
    executed = []
    def fake_run(cmd, shell, check):
        executed.append(cmd)
        return 0
    monkeypatch.setattr(subprocess, "run", fake_run)
    task = {"command": "echo test"}
    TaskCommand().execute(task)
    assert "echo test" in executed

def test_task_script(monkeypatch):
    executed = []
    def fake_run(cmd, shell, check):
        executed.append(cmd)
        return 0
    monkeypatch.setattr(subprocess, "run", fake_run)
    task = {"path": "echo script"}
    TaskScript().execute(task)
    assert "echo script" in executed
```

---

## Running the Tests

1. Install pytest (if not already installed):

   ```bash
   pip install pytest
   ```

2. Run tests from the root directory:

   ```bash
   pytest --maxfail=1 --disable-warnings -q
   ```
