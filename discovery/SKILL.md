---
name: discovery
description: Analyze and explore new or unfamiliar codebases to identify hot paths, architectural patterns, and high-complexity areas. Use when the user wants to understand a new repository, find frequently modified files, assess code difficulty, or analyze specific subdirectories of a project.
---

# Codebase Discovery

## Quick start

To begin exploring a codebase, request a general summary of the root directory or a specific sub-section:
`Discover the codebase, focusing on the ./src/payments directory.`

## Workflows

**1. Scoped Initialization**
* Check if the user specified a sub-section (e.g., `./backend/api`). If yes, restrict all subsequent analysis strictly to that path.
* Map the directory structure and identify key configuration files (e.g., `package.json`, `go.mod`, `docker-compose.yml`) to determine the tech stack.

**2. Identifying Hot Paths**
* Locate the most frequently modified files to find active development areas. 
* *Tip: Use the `scripts/get_hot_paths.sh` utility or run `git log --name-only | sort | uniq -c | sort -rg | head -20`.*
* Identify core execution paths and main entry points (e.g., `main.py`, `index.ts`).

**3. Assessing Complexity & "Difficult" Code**
* Identify files with unusually high line counts ("God classes" or massive utility files).
* Flag areas with deep nesting, complex conditional logic, or lacking test coverage.
* Summarize the purpose of these complex files to aid user comprehension.

**4. Dependency & Architecture Mapping**
* Trace how the isolated sub-section or main application connects to external services or internal modules.
