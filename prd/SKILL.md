---
name: prd
description: Turn the current conversation context into a PRD. Use when user wants to create a PRD from the current context.
---

Take the current conversation and codebase understanding and produce a PRD. 

## Process

1. **Analyze Context:** Review the entire conversation history, user requests, and any provided codebase context to extract the core product idea, goals, and constraints.
2. **Define Scope:** Establish clear boundaries for what is included in this release (In-Scope) and what is deferred (Out-of-Scope).
3. **Technical Considerations:** Leverage the codebase understanding to outline technical dependencies, potential architecture impacts, and constraints.
4. **Synthesize & Format:** Structure the gathered information into the standardized PRD format below.

<prd-template>

### 1. Meta Information
* **Title:** [Feature/Product Name]
* **Status:** Draft
* **Target Release:** [If applicable]

### 2. Overview
* **Problem Statement:** What user problem are we solving?
* **Product Vision/Objective:** What is the goal of this feature?
* **Target Audience:** Who is this for?

### 3. Scope
* **In-Scope:** What are we building right now?
* **Out-of-Scope:** What are we explicitly NOT building in this iteration?

### 4. Requirements & User Stories
* **User Stories:** (Format: *As a [user type], I want to [action] so that [benefit].*)
* **Functional Requirements:** (Specific system behaviors and features)
* **Non-Functional Requirements:** (Performance, security, accessibility, scalability)

### 5. Technical Context
* **Codebase Impact:** Existing systems or modules affected.
* **Dependencies:** APIs, third-party tools, or other teams needed.

### 6. Testing Decisions

A list of testing decisions that were made. Include:

- A description of what makes a good test (only test external behavior, not implementation details)
- Which modules will be tested
- Prior art for the tests 
