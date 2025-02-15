# Git Branching Strategy for Zawjen.net Team

## Overview
This document outlines a simple and effective Git branching strategy for the **Zawjen.net** team, which is working remotely across different time zones on multiple repositories, including **NestJS, NextJS, React Native, Python**, and **documentation/json datasets**. The goal is to ensure smooth collaboration, avoid conflicts, and streamline development.

## Key Principles
1. **Simplicity** – Keep the branching model easy to understand and use.
2. **Parallel Development** – Allow multiple team members to work on different features and bug fixes simultaneously.
3. **Continuous Integration** – Ensure that changes are frequently integrated into the main branch to prevent long-lived branches.
4. **Stable Production Releases** – Maintain a stable `main` branch while allowing active development on `develop`.
5. **Clear Separation of Concerns** – Use specific branches for features, bugs, and hotfixes.

## Branching Model
We follow a lightweight **Git Flow** approach with the following branches:

- **`main` (Production Branch)** – Always contains stable, production-ready code.
- **`develop` (Development Branch)** – Latest integrated code, ready for testing before release.
- **`feature/<name>` (Feature Branches)** – Used for new feature development.
- **`bugfix/<name>` (Bug Fix Branches)** – Used for fixing non-critical bugs.
- **`hotfix/<name>` (Hotfix Branches)** – Used for urgent production fixes.
- **`release/<version>` (Release Branches)** – Used for preparing a new release.

---

## Workflow

### 1. Setting Up the Repository
Each repository should have the following permanent branches:
- `main` → Protected, only merged from `release` or `hotfix`
- `develop` → All feature and bugfix branches are merged here

### 2. Developing a Feature
1. **Create a feature branch** from `develop`:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/login-system
   ```
2. **Work on the feature**, commit changes frequently:
   ```bash
   git add .
   git commit -m "Added login form UI"
   ```
3. **Push the branch** to the remote repository:
   ```bash
   git push origin feature/login-system
   ```
4. **Create a Pull Request (PR)** to merge into `develop`.
5. After review and approval, **merge into `develop`** and delete the feature branch.

### 3. Fixing a Bug
1. **Create a bugfix branch** from `develop`:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b bugfix/fix-login-error
   ```
2. **Fix the bug**, commit, and push changes.
3. **Create a PR** to merge into `develop`.
4. After testing, merge and delete the bugfix branch.

### 4. Releasing a New Version
1. **Create a release branch** from `develop`:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b release/v1.2.0
   ```
2. **Test, fix minor issues, update version numbers**.
3. After approval, **merge into `main`** and create a Git tag:
   ```bash
   git checkout main
   git merge release/v1.2.0
   git tag -a v1.2.0 -m "Release version 1.2.0"
   git push origin main --tags
   ```
4. **Merge back into `develop`**:
   ```bash
   git checkout develop
   git merge main
   git push origin develop
   ```
5. **Delete the release branch**.

### 5. Handling Hotfixes (Urgent Fixes)
1. **Create a hotfix branch** from `main`:
   ```bash
   git checkout main
   git pull origin main
   git checkout -b hotfix/fix-critical-login-issue
   ```
2. **Fix the issue, commit, and push changes.**
3. **Create a PR** to merge into `main`.
4. After merging, **tag the release** and deploy immediately.
5. **Merge back into `develop`** to keep both branches updated.

---

## Example Scenarios

### Example 1: Adding a New Feature (Login System)
1. Developer creates `feature/login-system` from `develop`.
2. Works on the feature and commits changes.
3. Pushes to GitHub and creates a PR.
4. After code review, the PR is merged into `develop`.

### Example 2: Fixing a Bug (Login Button Not Working)
1. Developer creates `bugfix/fix-login-button` from `develop`.
2. Fixes the bug, commits, and pushes changes.
3. Creates a PR and merges into `develop`.

### Example 3: Releasing Version 1.2.0
1. Release manager creates `release/v1.2.0` from `develop`.
2. Tests, updates versioning, and prepares deployment.
3. Merges `release/v1.2.0` into `main`.
4. Tags version `v1.2.0` and deploys.
5. Merges `main` back into `develop`.

### Example 4: Hotfix for Production Issue (Login Down)
1. Developer creates `hotfix/fix-login-issue` from `main`.
2. Fixes the issue, commits, and pushes changes.
3. Creates a PR to merge into `main`.
4. Tags and deploys the fix.
5. Merges back into `develop` to keep both branches in sync.

---

## Best Practices
- **Keep feature branches short-lived** – Merge frequently to `develop`.
- **Write meaningful commit messages** – Helps track changes easily.
- **Use PR reviews** – Every change should be reviewed before merging.
- **Tag releases properly** – Always tag versions for clarity.
- **Avoid committing directly to `main` or `develop`** – Use feature/bugfix/hotfix branches.

---

## Summary
| Branch Type  | Base Branch | Purpose |
|-------------|------------|---------|
| `main` | - | Production-ready code |
| `develop` | `main` | Active development branch |
| `feature/<name>` | `develop` | New features |
| `bugfix/<name>` | `develop` | Bug fixes |
| `hotfix/<name>` | `main` | Urgent production fixes |
| `release/<version>` | `develop` | Preparing a new version |

This strategy ensures a **structured, conflict-free, and scalable** development process for **Zawjen.net** with multiple contributors working remotely on open-source repositories.

---

## Next Steps
- All developers should follow this workflow.
- CI/CD should be set up to automatically deploy `main` updates.
- Maintain clear documentation and naming conventions.

Happy coding! 🚀

