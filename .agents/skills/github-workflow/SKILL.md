---
name: github-workflow
description: Runs sample project development through GitHub issues—assign @me when starting work, small commits with issue references, push, and PRs that close or reference issues. Use when starting or finishing tracked work, when creating follow-up tasks, or when the user mentions issues, PRs, backlog, or GitHub workflow.
---

# GitHub workflow (sample project)

## When this applies

Use this skill for implementation work in this repository when work should align with GitHub tracking—not for one-off local experiments unless the user opts out.

## Source of work

- **GitHub issues** are the backlog. Prefer working from an open issue over treating chat as the only spec. Use the Issues tab (labels, milestones, **blocked by** links) to see dependencies and priority.
- **[AGENTS.md](../../../AGENTS.md)** (Development workflow) is the canonical short policy; this skill expands how to execute it.

## Creating issues

- If you find a bug, missing test, or follow-up that is not already tracked, **create a GitHub issue** (`gh issue create`) with a clear title and scope.
- **Bug reports:** apply the **`bug`** label so they can be filtered and distinguished from enhancements. Example: `gh issue create --label bug --title "…" --body "…"`, or `gh issue edit <n> --add-label bug` after creation.
- Prefer **one focused issue** per coherent change; split large work with dependencies (GitHub **blocked by** relationships) when useful.
- For `gh` syntax and flags, use [.agents/skills/gh-cli/SKILL.md](../gh-cli/SKILL.md).

## Starting work on an issue

- When you **start** work on an issue, **assign it to the current user** immediately: `gh issue edit <n> --add-assignee @me` (or the equivalent in the GitHub UI).
- Skip this only if the user explicitly works without `gh` auth or the issue is read-only for some reason.

## Branches and commits

- Use a branch named for the work, e.g. `feat/short-topic` or `fix/issue-12-description`.
- **Commit often** in small logical steps.
- For message **shape** (Conventional Commits subject), follow [.agents/skills/commit/SKILL.md](../commit/SKILL.md).
- **Always tie commits to the issue** when there is one:
  - Preferred: include the number in the subject, e.g. `feat(db): add events migration (#12)`.
  - Alternatively: a single footer line `Refs: #12` or `Fixes #12` / `Closes #12` when merging should close the issue (GitHub recognizes these keywords in merge commits and PR bodies).

If the commit skill’s “no footers” guidance conflicts with linking, **prefer issue linkage**: use `(#N)` in the subject, or one `Refs:`/`Fixes:` footer.

## Push

- **Push** the branch to GitHub when a slice of work is complete or when stopping for a handoff—do not leave completed work only on a local machine unless the user asked.

## Pull request

- Open a **PR** when the branch is ready for review or merge (`gh pr create`).
- In the PR description, **link the issue**: e.g. `Closes #12` or `Refs #12` so GitHub connects the work.
- Summarize what changed and how to verify (tests run, manual checks).

## Quick checklist

- [ ] Issue exists (or created) for this work
- [ ] Bug issues have the **`bug`** label
- [ ] Issue assigned to current user (`@me`) when work started
- [ ] Commits are small and reference `#N`
- [ ] Branch pushed
- [ ] PR opened with `Closes` / `Refs` to the issue
