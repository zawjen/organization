
# cli-install
Write detailed [CLI Install] requirements document for a developer. Write code for each Python class, complete functionality and its unit tests using pytest mentioned below. Follow all instructions below. Do not skip any requirement below.

The CLI built using following tech stack
1- Python 

Feature Details
- All classes must be under sdk folder
- Program should start from main.py
- A command line argument CliArgs class that accepts following arguments. Create a table in document.
    - --folders: Optional comma separated list of Json Task folder paths to install
    - --files: Optional comma separated list of Json Task file paths to install
    - --thread-count: Optional number of threads to execute tasks. Default is 1. 
    - --git-root: Optional path of git root folder. Default is C:\zawjen\git
- A class TaskManager which iterates over list of folders and files and create --thread-count number of threads for class TaskRunner passing it file name. If --thread-count is not specified use 1 thread by default to execute task files specified in --folders or --files
- Time spend on important or long running steps should be logged using a Logger class which will have log(self, message, start_time) to calculate time_spent
- To execute Json task file write a python class TaskRunner called from main.py that reads .json file which contains array of task. Create separate class for each Task Type derived from base class Task. e.g. TaskInstall, TaskGit, TaskCommand
- Each Task has type which could be install, git, command or script. 
- If type = install the class should download specified exe, msi etc and run it to install it. 
- If type = git, the class should git pull specified repo in url attribute to the location specified in --git-root. 
- If type = command, the class should run specified powershell, bat, or bash command depending on shell attribute.
- If type = script, then path attribute could be a absolute or relative path of powershell, bash, bat or exe file or any other type of file. The system should run or execute that file. 
- Follow zawjen.net coding convention and clean coding principals
- Write 100% coverage unit tests
- Solution must be highly performant, low on memory, cpu and battery
- Highly scalable and maintainable
- Use try-catch and log errors
- See Zawjen.net [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md) for further details about the terms used in this document
- write code for each class
- write 100% test coverage using pytest.
- Write code for each Python class, complete functionality and its unit tests using pytest mentioned
