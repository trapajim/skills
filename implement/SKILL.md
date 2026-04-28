---
name: implement
description: Implement a task with red-green-refactor loop. Use when user wants to build features or fix bugs using TDD.
---

# Implement

## Core Philosophy and Principles

**Red Green Refactor** Write a failing test for a small piece of functionality, write the minimum amount of code necessary to make the test pass, improve the code's structure and quality without altering its functionality.

**Quality as Priority** Tests serve as a safety net (preventing regressions) and documentation

**Good tests** describe _what_ the system does, not _how_ it does it. A good test reads like a specification - "user can checkout with valid cart" tells you exactly what capability exists. These tests survive refactors because they don't care about internal structure.

**Bad tests** are coupled to implementation.

For concrete examples, anti-patterns, and checklists, see [tests.md](./tests.md).

## Context gathering 

If the user passes a Github ID (e.g. 1233, #1233) use the Github MCP to gather informations about the task. 

* Fetch the issue
* Fetch a potential parent issue
* Read the PRD if linked

**The issue itself should be treated as source of truth, if there are conflicts within the PRD or parent issues confirm with the user first** 

## Workflow

### 1. Planning

Before starting with the implementation confirm the following: 

- [ ] Confirm potential interface changes
- [ ] Confirm test priorities
- [ ] List the behaviours to test
- [ ] Get approval

### 2. Implement

Write one test to confirm one behavior perferably in a table driven style. 
Create enough code to pass the current test. 

### 3. Loop
Repeat step two until the task is completed

Rules:

- one test at a time
- do not anticipate future tests
- keep tests focused

### 4. Refactor

After all tests pass, look for refactoring candidates

- [ ] extract duplication
- [ ] break up long methods
- [ ] create value objects where applicable 

** never refactor if tests are failing **

