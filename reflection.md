# Day 8 — AI Didn't Make Code Review Easier. It Made It Harder.

*A reflection on PR reviews, framework design, and what "senior" actually means in the AI era.*

---

## The thing nobody tells you about AI-assisted development

When I started pairing with Claude Code on the String Calculator kata, I expected it to feel like a productivity boost. Write a failing test, Claude fills in the green, I refactor — clean loop.

What I didn't expect was that **the hardest part of the whole week was stopping Claude from doing too much.**

Every time I wrote a test for empty string returning `0`, Claude wanted to ship the entire delimiter parser, negative number validation, and call counter in one go. Technically correct code. Wrong discipline. I was practicing Red → Green → Refactor. Claude was practicing "anticipate everything and preempt the next 6 tests."

That moment taught me something that changed how I think about code review entirely.

---

## Code review in the AI era: your job just changed

Before AI tools, a PR reviewer was checking:

- Is the naming consistent?
- Did they handle the null case?
- Is this loop going to blow up at scale?
- Does this match our style guide?

Claude does all of that now — faster than any human, every time, without bias or fatigue.

So what's left for the human reviewer?

**The question you're now asking is: does this code fit the design we agreed on?**

Not "is this code correct?" — Claude already checked that.  
Not "does this pass the tests?" — CI already checked that.  
Not "is this readable?" — Claude wrote it to be readable.

The human reviewer's new job is:

- **Did we build the right thing or just a working thing?**
- **Did this solve the immediate problem or did it over-engineer for problems we don't have yet?**
- **Does this sit in the right layer of the architecture, or did Claude find a clever shortcut that violates the design boundary?**
- **Does this test document behaviour, or does it just make CI green?**

In my kata work, the biggest review question became: *"Did Claude jump ahead of the current failing test?"* That's an architectural question, not a syntax question. It's about whether the implementation reflects intent or reflects AI eagerness.

**The new PR review is design review. Syntax is table stakes. Design is the job.**

---

## What this means for framework builders

If your framework's conventions exist only in a README or a team wiki, Claude will violate them in seconds. Not maliciously — it just has no way to know.

Here's what I learned building the `lint-check` CLI and pairing with Claude on the kata:

**Claude reads everything as signals.** Names, folder structure, file contents, commit messages. If your architecture is implicit — lived in people's heads and enforced by social norms — Claude has no signal to work from. It fills gaps with patterns from its training data, which means patterns from every other codebase it's ever seen.

**The practical answer: make your conventions machine-readable.**

A `CLAUDE.md` at the repo root that says *"this is a CLI tool, output is always JSON, never add interactive prompts"* is not documentation for humans. It's a constraint for the agent. A `SKILL.md` that encodes your refactoring standards is not a checklist — it's executable team knowledge.

**If Claude can violate your design convention in three seconds, your convention is not a constraint. It's a suggestion.**

Framework builders in the AI era need to think about two audiences simultaneously: the human reading the README and the agent reading the codebase. The human understands implication. The agent needs explicit signal.

Design so both can navigate your framework without guessing.

---

## The shift that actually matters: co-author → skill composer

Here's the distinction I kept coming back to this week:

A **co-author** writes code with you. The value exists in that conversation. When the session ends, the value ends. Next teammate starts from zero.

A **skill composer** encodes expertise into a reusable `SKILL.md` that the whole team runs. The value compounds. Every teammate who touches the codebase gets the same quality of review, the same TDD discipline check, the same refactoring critique — without needing to know how to prompt for it.

This week I built:

- **`tdd-test-audit`** — audits RSpec tests against 7 TDD criteria. Anyone on the team can run `/tdd-test-audit spec/string_calculator_spec.rb` and get a structured review as good as a senior pair would give.
- **`refactoring-critique`** — evaluates Ruby implementation code against 8 refactoring criteria after the green phase. Catches skipped refactor steps.
- **`test-desiderata`** — evaluates tests against Kent Beck's 12 Test Desiderata. The deepest test quality framework I know, now runnable by anyone.
- **`lint-check`** — companion skill for the Day 5 Node CLI. CLI does the computation (finds `console.log` violations, outputs JSON), skill does the interpretation (explains each violation, recommends the right fix, writes the CI integration snippet). Neither is useful without the other. Together they're a workflow.

The test I used for every skill: *"Can a teammate who has never seen this repo pick up this SKILL.md cold tomorrow and get a useful output?"*

If the answer was no, the skill wasn't done yet. That's the standard.

---

## What SC-3 / Senior-1 looks like in the AI era

At PQF, SC-3 / Senior-1 behaviour is not about writing more code. It's about building things that make the people around you more capable.

Before AI, that looked like good architecture decisions, mentorship, strong code review, and documentation that actually helps new teammates ramp up.

In the AI era, it looks like exactly the same things — but now there's a new surface: **the skill layer**.

A junior engineer uses Claude to solve their immediate problem.  
A senior engineer writes the skill so Claude solves the whole team's recurring problem.

The difference is the same as the difference between writing a one-off script and writing a library. One solves today's problem. The other changes what's possible for everyone.

If you're writing prompts only for yourself, you're using AI as a personal tool.  
If you're writing skills your team adopts, you're using AI as infrastructure.

That's the shift.

---

## What I'm taking into next week

1. Every PR review I do from now on starts with: *"Does this fit the design?"* — not *"Is this correct?"*

2. Every convention I care about gets written into `CLAUDE.md` or a skill. If it's not machine-readable, it will be violated.

3. Every skill I write gets the cold-pickup test before I consider it done. Polished enough for a teammate who has no context. Specific enough to produce consistent output. Self-contained enough to not need me to explain it.

4. The question for every AI interaction is: *"Am I building something reusable, or just solving today?"*

---
