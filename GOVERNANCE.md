# Open Governance & Contribution Guidelines for Zawjen.net

Zawjen is **not** a technical project. It is on a mission to spread the  `sincerity` of the Quran. Zawjen leadership and governance practices should be aligned with the principle of `sincerity` as established by the Quran. The principle of `sincerity` is loud and clear **"Indeed, those who believed and those who were Jews or Christians or Sabians---those (among them) who believed in Allah and the Last Day and did righteousness---will have their reward with their Lord, and no fear will there be concerning them, nor will they grieve."** (Quran 2:62)

This document outlines the practices and guidelines for managing the Zawjen.net project using open source principles. It covers transparent governance, decision-making processes, leadership diversity, community role invitations, and fair assignment of pull request reviews.

---

## 1. Governance Model for Zawjen.net

The `GOVERNANCE.md` file defines the project’s leadership, decision-making process, roles, responsibilities, and how conflicts are resolved.

### 1.1 Decision-Making Process
- **Lazy Consensus:** Routine decisions are accepted if no objections are raised within a set period (e.g., 72 hours).
- **Majority Voting:** Critical decisions are decided via a vote:
  - ✅ `+1` means “approve”
  - 🟡 `0` means “neutral”
  - ❌ `-1` means “reject” (with a reason provided)
- All votes and discussions are documented publicly.

### 1.2 How to vote?
A user can add their vote in a GitHub issue using Emoji reactions in the first comment with text `Votes`:

- ✅ **Thumbs Up (👍)** → Approve  
- ❌ **Thumbs Down (👎)** → Reject  
- 🟡 **Neutral (😐)** → Neutral  

For **(👎) Reject**, please specify a reason in comments.

#### **Steps:**  
1. Open the GitHub issue.  
2. Click the **reaction button** (😊) in the top right corner of the post.  
3. Select **👍, 👎, or 😐** to vote.  

### 1.2 Roles & Responsibilities

#### Contributors
- Open to anyone who contributes via Pull Requests (PRs).
- Must adhere to the project’s Code of Conduct.

#### Committers
- Have merge rights and participate in code reviews.
- To become a committer, a contributor should:
  - Submit at least 5 meaningful PRs,
  - Actively participate in public discussions,
  - Receive a nomination from an existing committer followed by a vote.

#### Leadership Committee
- Oversees the project direction, release management, and ensures open governance.
- Members are elected based on merit and community contributions.

### 1.3 Release Process
- A release requires approval from at least three leadership committee members.
- All release decisions are documented publicly.

### 1.4 Conflict Resolution
- Disputes are first resolved via discussion; if unresolved, they are escalated to a leadership committee vote.
- For persistent issues, further escalation procedures may be defined.

### 1.5 Ensuring No Single Entity Control
- No single company or person may dominate project decisions.
- Leadership positions must be distributed among a diverse set of contributors.

---

## 2. Decision-Making: Lazy Consensus and Majority Voting on GitHub

### 2.1 Lazy Consensus Voting
- **Definition:** A proposal is accepted if no objections are raised within a predetermined time frame (e.g., 72 hours).
- **Implementation Using GitHub Issues:**
  1. **Create an Issue:**
     - Title: `[Lazy Consensus] <Proposal Title>`
     - Description: Provide full details of the proposal and specify that if no objections are raised within 72 hours, the proposal will be accepted.
  2. **Announcement:**
     - Clearly state the voting period.
  3. **Monitor and Conclude:**
     - If no objections are received, post a final comment stating:
       ```
       No objections raised within 72 hours. The proposal is accepted by lazy consensus.
       ```
  4. **Document:**
     - Close the issue and reference it in project records.

### 2.2 Majority Voting for Major Decisions
- **Definition:** Used for decisions requiring explicit approval.
- **Implementation Using GitHub Issues or Discussions:**
  1. **Create an Issue:**
     - Title: `[VOTE] <Proposal Title>`
     - Description: Provide details and instructions on how to vote.
     - Voting Instructions:
       ```
       Please vote by commenting:
       ✅ +1 (Approve)
       🟡 0 (Neutral)
       ❌ -1 (Reject) – please provide your reason.
       Voting closes on [specified date].
       ```
  2. **Collect Votes:**
     - Contributors vote by commenting on the issue.
  3. **Count Votes:**
     - Tally the votes after the deadline.
  4. **Document the Outcome:**
     - Post a final comment summarizing the results and close the issue.

### 2.3 Choosing Between GitHub Issues and Discussions for Lazy Consensus
- **GitHub Issues:**
  - **Pros:** Better for formal decision-making; maintains a clear, archived record.
  - **Cons:** Less support for threaded conversations.
- **GitHub Discussions:**
  - **Pros:** Great for brainstorming and threaded discussions.
  - **Cons:** Not as ideal for formal, archived decision records.
- **Recommendation:** Use **GitHub Issues** for formal lazy consensus votes to ensure all decisions are documented and transparent.

---

## 3. Ensuring No Single Company or Person Controls the Project

### 3.1 Promoting Leadership Diversity
- **Principle:** Leadership roles must be earned through merit.
- **Practices:**
  - Ensure committers and leadership members come from multiple companies or independent backgrounds.
  - Rotate roles such as Release Manager to avoid centralizing power.
  - Document all decisions publicly to maintain accountability.

### 3.2 Transparent and Public Decision-Making
- All major discussions and votes must occur on public platforms (GitHub Issues, Discussions, or public mailing lists).
- Avoid private chats (e.g., Slack or WhatsApp) for decision-making.

---

## 4. Inviting Community Members to Leadership Roles

### 4.1 Identification and Nomination
- **Track Contributions:** Use GitHub insights to monitor activity (PR submissions, issue discussions, reviews).
- **Nomination Process:**
  - Open a public GitHub Issue (e.g., `[VOTE] Nominate @username as a Committer`).
  - Leadership committee members and existing committers vote using the defined voting model (`+1`, `0`, `-1`).

### 4.2 Granting Leadership Roles
- **After Approval:**
  - Add the contributor to the GitHub organization with appropriate permissions.
  - Update the `GOVERNANCE.md` file to reflect the change.
- **Encouragement:** Newly promoted members are asked to mentor others and actively participate in code reviews and project discussions.

---

## 5. Fair Assignment of PR Reviews Using GitHub

### 5.1 Using CODEOWNERS for Automatic Review Assignment
- **Purpose:** Automatically assign knowledgeable reviewers to relevant parts of the code.
- **Steps:**
  - Create a `.github/CODEOWNERS` file in the repository.
  - Define rules that map file paths or directories to specific reviewers.

**Example:**
```bash
# Assign reviewers for database-related changes
src/database/*  @db-expert1 @db-expert2

# Assign reviewers for API-related changes
src/api/*       @api-dev1 @api-dev2

# Assign reviewers for documentation changes
docs/*          @docs-team
```

### 5.2 Using GitHub’s Auto-Assignment and Actions
- **Purpose:** Distribute review duties fairly by random or pre-defined assignment.
- **Steps:**
  - Enable branch protection rules that require a set number of approvals.
  - Use a GitHub Action to randomly assign reviewers.

**Example GitHub Action (`.github/workflows/assign-reviewers.yml`):**
```yaml
name: Auto Assign PR Reviewers
on: [pull_request]
jobs:
  assign_reviewers:
    runs-on: ubuntu-latest
    steps:
      - name: Assign Random Reviewers
        uses: hmarr/auto-assign-action@v3
        with:
          reviewers: db-expert1, db-expert2, api-dev1, api-dev2
          num-reviewers: 2
```
