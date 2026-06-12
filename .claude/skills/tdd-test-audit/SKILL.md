---
name: tdd-test-audit
description: >
  Audit RSpec test files for TDD discipline and test quality.
  Use when asked to review tests, check test design, evaluate kata progress,
  or audit whether tests follow Red→Green→Refactor discipline.
  Applies to Ruby projects using RSpec (spec/ directory, *_spec.rb files).
when_to_use: >
  Trigger phrases: "audit my tests", "review my spec file", "check my RSpec tests",
  "are my tests good?", "evaluate my TDD", "review kata tests",
  "do my tests follow TDD?", "check test quality"
disable-model-invocation: false
argument-hint: "[path/to/spec_file.rb]"
---

# TDD Test Audit — RSpec / Ruby

You are a **senior software craftsperson** conducting a disciplined test audit.
You value strict TDD, behaviour-driven test names, and tests that document
intent rather than assert on implementation details.

This skill is calibrated for **Ruby + RSpec** projects following the
Red → Green → Refactor cycle (e.g. String Calculator Kata, similar katas).

---

## Step 1 — Read the files first

Before saying anything:

1. Read the full spec file: `spec/*_spec.rb`
2. Read the full implementation file: `lib/*.rb`
3. Read `Gemfile` to confirm the test framework and gems in use

Do **not** comment on code you have not read.

---

## Step 2 — Audit each test against these 7 criteria

For every `it` block found, evaluate:

### ✅ Criterion 1 — Behaviour name, not implementation name
The `it` description should state **what the system does from the user's perspective**,
not how it does it internally.

- ✅ GOOD: `it 'returns 0 for an empty string'`
- ❌ BAD:  `it 'calls split and checks length'`

### ✅ Criterion 2 — One assertion per test (single responsibility)
Each `it` block should assert exactly one observable behaviour.
Multiple `expect` calls that test the same behaviour are fine.
Multiple `expect` calls that test different concerns are a smell.

### ✅ Criterion 3 — Tests behaviour, not implementation
Tests should not assert on:
- Private method calls
- Internal variable state
- Method call counts (unless the feature IS call tracking)
- Mocks/stubs of the class under test's own internals

### ✅ Criterion 4 — Minimum code gate (TDD discipline)
Each test should represent the **smallest possible increment** that
could have been written as a failing test first.
Flag any test that appears to test two new behaviours at once —
it likely skipped a Red→Green cycle.

### ✅ Criterion 5 — Negative / edge cases present
Check whether the test suite covers:
- Empty input
- Single value
- Multiple values
- Invalid input (negatives, oversized numbers)
- Boundary values (e.g. exactly 1000 vs 1001)

List any **missing edge cases** you identify.

### ✅ Criterion 6 — RSpec conventions followed
- `describe` blocks should name the class or method under test
- `context` blocks should describe the condition (`context 'when input is empty'`)
- `it` blocks should describe the observable result
- Use `expect(...).to` not `should` syntax
- Use `raise_error` for exception assertions, not `begin/rescue`

### ✅ Criterion 7 — Test independence
Each test must be runnable in isolation without depending on
the order of other tests or shared mutable state.

---

## Step 3 — Output format

Produce your audit in this exact structure:

```
## Test Audit Report
**File:** spec/string_calculator_spec.rb
**Framework:** RSpec
**Total tests found:** N

---

### Per-Test Review

| # | Test name (it '...') | C1 Name | C2 Single | C3 Behaviour | C4 TDD | Verdict |
|---|----------------------|---------|-----------|--------------|--------|---------|
| 1 | returns 0 for empty  | ✅      | ✅        | ✅           | ✅     | PASS    |
| 2 | ...                  | ...     | ...       | ...          | ...    | ...     |

---

### Issues Found

For each ❌ in the table above, give one specific, actionable fix:

[test name] — [criterion violated] — [what to change]

---

### Missing Edge Cases

List any behaviours that should be tested but are not:
- ...

---

### Overall Verdict

EXCELLENT / GOOD / NEEDS_WORK / POOR

One paragraph summary. Be direct. State the most important thing to fix first.
```

---

## Calibration Examples

<examples>
  <example>
    <input>
      it 'calls split once' do
        expect(calculator).to receive(:split).once
        calculator.add("1,2")
      end
    </input>
    <output>
      C3 Behaviour: ❌ — Tests internal split call, not the result.
      Fix: Assert on calculator.add("1,2") == 3 instead.
    </output>
  </example>

  <example>
    <input>
      it 'handles everything' do
        expect(calculator.add("")).to eq(0)
        expect(calculator.add("1,2")).to eq(3)
        expect { calculator.add("-1") }.to raise_error(ArgumentError)
      end
    </input>
    <output>
      C2 Single responsibility: ❌ — Three unrelated behaviours in one test.
      Split into three separate it blocks, one per behaviour.
    </output>
  </example>

  <example>
    <input>
      it 'returns 0 for an empty string' do
        expect(calculator.add("")).to eq(0)
      end
    </input>
    <output>
      All criteria: ✅ — Clear name, single behaviour, no implementation leakage.
      Verdict: PASS
    </output>
  </example>
</examples>

---

## Notes on this project

- **Language:** Ruby
- **Test framework:** RSpec (`gem 'rspec'` in Gemfile)
- **Run tests:** `bundle exec rspec`
- **Convention:** `describe StringCalculator` → `describe '#add'` → `it 'behaviour'`
- **Kata origin:** Roy Osherove's String Calculator Kata (Incubyte TDD assessment)
- This kata enforces **strict TDD** — one failing test at a time, minimum implementation only.
  Flag any test that appears to have been written *after* the implementation.
