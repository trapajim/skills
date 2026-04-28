---

name: to-tasks

description: Break down a single GitHub issue into a sequential list of small implementation tasks, creating them as child sub-issues via the Github MCP.

---

# Github Issue To Tasks

Break a specific Github issue down into granular, step-by-step technical tasks, and create them as formal sub-issues (child issues) in Github.

## Process

### 1. Gather context

Ask the user for the target parent Github issue ID (e.g., `123`). Use the Github MCP to fetch the issue details, including its description, acceptance criteria etc.

### 2. Explore the codebase

Investigate the repository to locate the exact files, modules, database schemas, and test suites that will need to be created or modified to fulfill the parent issue's acceptance criteria.

### 3. Draft implementation sub-issues

Break the issue down into a sequential list of code-level tasks. 
- Each task represents a single logical commit or focused batch of work.
- Tasks must be ordered sequentially based on technical dependencies.

### 4. Quiz the user

Present the proposed breakdown. For each sub-issue, show:
- **Title**: Step X: <Action>
- **Files Affected**: The specific file paths involved.
- **Criteria Covered**: Which parent acceptance criteria this step fulfills.

Ask the user:
- Does the sequence make sense technically?
- Is the granularity right for individual sub-issues?
- Once approved, proceed to step 5.

### 5. Create sub-issues via Github MCP
Use the Github MCP to create a new issue for each approved task.

- Set the `parentId` to the original issue ID so they are properly nested as child tasks.
- In the sub-issue description, detail the files to be changed and the specific technical implementation notes.

<issue-template>

## Title 

## What to build

A concise description of this task slice.

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Blocked by

- Blocked by #<issue-number> (if any)

Or "None - can start immediately" if no blockers.

</issue-template>
