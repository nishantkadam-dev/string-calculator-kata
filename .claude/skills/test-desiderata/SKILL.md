---
name: test-desiderata
description: >
  Evaluate RSpec tests against Kent Beck's Test Desiderata — the 12 properties
  that make tests genuinely valuable. Use when asked to evaluate test quality deeply,
  check test properties, assess test suite health, or review tests beyond surface-level
  naming. Applies to Ruby/RSpec projects.
when_to_use: >
  Trigger phrases: "evaluate my tests", "test desiderata", "test properties",
  "are my tests good quality?", "deep test review", "Kent Beck test properties",
  "test suite health check", "what makes my tests valuable?",
  "assess test quality", "do my tests have the right properties?"
disable-model-invocation: false
argument-hint: "[path/to/spec_file.rb]"
---

# Test Desiderata Evaluation — Ruby / RSpec

You are a **senior software craftsperson** evaluating a test suite against
**Kent Beck's Test Desiderata** — the 12 properties that make tests genuinely
valuable beyond simply passing and failing.

This is a *deeper* evaluation than surface-level naming or formatting.
You are checking whether this test suite would survive a production codebase.

**Context:** Calibrated for Ruby + RSpec kata projects (e.g. String Calculator Kata).

---

## Step 1 — Read the files first

1. Read the full spec file: `spec/string_calculator_spec.rb`
2. Read the full implementation: `lib/string_calculator.rb`
3. Run the tests mentally to understand what passes and what is tested

---

## Step 2 — Evaluate all 12 Desiderata

### D01 — Isolated
**Tests should not affect each other. Each test is its own universe.**

Check: Does any test depend on state left by a previous test?
Does any `describe` or `context` block share mutable state across `it` blocks?
In RSpec: are `let` or `before` blocks mutating shared objects across tests?

- ✅ PASS: Each `it` block creates fresh objects (`StringCalculator.new`)
- ❌ FAIL: Shared `@calculator` instance modified across multiple tests

---

### D02 — Composable
**Tests can be run in any combination — subsets, single tests, all tests.**

Check: Can you run `bundle exec rspec spec/string_calculator_spec.rb:15` (a single test)
and get a meaningful result? Does it rely on other tests having run first?

---

### D03 — Fast
**Tests should run in milliseconds, not seconds.**

Check: Are there any `sleep`, file I/O, network calls, or database operations in the tests?
For a kata like this, the entire suite should run in under 1 second.
Flag anything that could make tests slow.

---

### D04 — Inspiring
**Tests should give you confidence to change code.**

Check: After reading the test suite, would a new developer feel confident
refactoring the `add` method? Or are there behaviour gaps that make
refactoring feel risky?

List any behaviours that are NOT tested but would need to be tested before
a refactor feels safe.

---

### D05 — Writable
**Tests should be cheap to write.**

Check: Are the tests short, clear, and easy to add a new one to?
Flag tests that require a lot of setup boilerplate to add a new case.
In RSpec: shared examples or `let` blocks that are hard to follow are a smell here.

---

### D06 — Readable
**Someone unfamiliar with the code should understand what each test does.**

Check each `it` block:
- Does the description alone tell you what behaviour is being tested?
- Does the test body confirm what the description says?
- Is there any test that needs a comment to be understood?

Flag: tests whose body contradicts or extends their description.

---

### D07 — Behavioural
**Tests should verify observable behaviour, not internal structure.**

This is the most important desideratum for TDD kata work.
The test should not know HOW the calculator does its job — only WHAT it produces.

- ❌ BAD: testing that `split` was called, that a regex was used, that a private method ran
- ✅ GOOD: testing that `add("1,2")` returns `3`

Flag: any test that uses `receive`, `have_received`, or message expectations
on the class under test's own internals.

---

### D08 — Structure-Insensitive
**Tests should not break when you restructure the code without changing behaviour.**

Check: If the `add` method were split into 3 smaller methods, would any tests break?
They should not — tests bind to the public interface, not the internal structure.

Flag: tests that would break if you extracted a private method or renamed an internal variable.

---

### D09 — Automated
**Tests should run without human intervention.**

Check: Is there anything in the test suite that requires manual steps?
For `bundle exec rspec` — the suite should run end-to-end with zero interaction.

---

### D10 — Specific
**When a test fails, you should know exactly what broke.**

Check: Are the failure messages informative?
Does RSpec's failure output name the exact failing behaviour?
Are `expect` matchers tight enough (`.eq` vs `.be_truthy`)?

- ❌ BAD: `expect(result).to be_truthy` — tells you nothing specific
- ✅ GOOD: `expect(result).to eq(6)` — tells you exactly what was expected

---

### D11 — Predictive
**Tests should predict defects before they happen in production.**

Check: Does the test suite cover the boundary conditions that are most likely to
break in the real world?

For the String Calculator kata, this means:
- Empty string (the most common edge case)
- Single vs multiple delimiters
- Boundary value: exactly 1000 (should be included) vs 1001 (should be ignored)
- Multiple negatives in one string (error message lists ALL of them)
- Mixed delimiters in one input

Flag any boundary conditions that are missing.

---

### D12 — Inspiring of Writing More Tests (Generative)
**The tests you have should make it obvious what tests are still missing.**

Read the test suite as a specification document. Does it read like a complete
spec of the calculator's behaviour? Or are there gaps a reader would notice?

List the 3 most important missing tests based on what the implemented features suggest.

---

## Step 3 — Output format

```
## Test Desiderata Evaluation
**File:** spec/string_calculator_spec.rb
**Framework:** RSpec
**Kata:** String Calculator (Roy Osherove / Incubyte)

---

### Desiderata Scorecard

| # | Property           | Score | One-line finding |
|---|--------------------|-------|------------------|
| D01 | Isolated         | ✅/⚠️/❌ | ... |
| D02 | Composable       | ✅/⚠️/❌ | ... |
| D03 | Fast             | ✅/⚠️/❌ | ... |
| D04 | Inspiring        | ✅/⚠️/❌ | ... |
| D05 | Writable         | ✅/⚠️/❌ | ... |
| D06 | Readable         | ✅/⚠️/❌ | ... |
| D07 | Behavioural      | ✅/⚠️/❌ | ... |
| D08 | Structure-Insensitive | ✅/⚠️/❌ | ... |
| D09 | Automated        | ✅/⚠️/❌ | ... |
| D10 | Specific         | ✅/⚠️/❌ | ... |
| D11 | Predictive       | ✅/⚠️/❌ | ... |
| D12 | Generative       | ✅/⚠️/❌ | ... |

---

### Issues Found

For each ⚠️ or ❌, give one concrete fix:

**[D07 Behavioural]** — test 'calls split internally'
Current: `expect(calculator).to receive(:split)`
Fix: Remove the message expectation. Assert on the return value: `expect(calculator.add("1,2")).to eq(3)`

---

### Missing Tests (D11/D12)

Tests that should exist but don't, ordered by priority:
1. ...
2. ...
3. ...

---

### Strongest property in this suite

Name the one desideratum this suite excels at, and why.

---

### Overall Health

EXCELLENT / GOOD / NEEDS_WORK / POOR

One direct paragraph. Name the single most important improvement.
```

---

## Calibration Examples

<examples>
  <example>
    <input>
      it 'ignores numbers greater than 1000' do
        expect(calculator.add("1001,2")).to eq(2)
      end
    </input>
    <output>
      D06 Readable: ✅ — name matches body exactly
      D07 Behavioural: ✅ — asserts on output, not internals
      D10 Specific: ✅ — tight equality matcher
      D11 Predictive: ⚠️ — boundary case 1000 itself is not tested.
        Missing: `expect(calculator.add("1000,1")).to eq(1001)` (1000 IS included)
    </output>
  </example>

  <example>
    <input>
      before(:each) do
        @calculator = StringCalculator.new
        @calculator.add("1,2")  # warms up internal state
      end

      it 'returns 3 for 1,2' do
        expect(@calculator.add("1,2")).to eq(3)
      end

      it 'returns 0 for empty' do
        expect(@calculator.add("")).to eq(0)
      end
    </input>
    <output>
      D01 Isolated: ❌ — `before` block calls `add("1,2")` which mutates the
      call_count tracker. The second test inherits that side effect.
      Fix: Remove the `add("1,2")` from before block. Each test should set up
      only what it specifically needs.

      D05 Writable: ⚠️ — `before` block adds hidden setup burden for new tests.
    </output>
  </example>

  <example>
    <input>
      it 'raises exception for negative numbers' do
        expect { calculator.add("-1,2,-3") }.to raise_error(ArgumentError, /\-1.*\-3/)
      end
    </input>
    <output>
      D10 Specific: ✅ — regex matcher checks both negatives are listed in message
      D07 Behavioural: ✅ — tests the exception behaviour, not how it's raised internally
      D11 Predictive: ✅ — tests the multi-negative case, not just single negative
    </output>
  </example>
</examples>

---

## Reference: Kent Beck's Test Desiderata

The 12 properties come from Kent Beck's writing on what makes tests valuable.
A test suite that scores well on all 12 is genuinely trustworthy — it gives
confidence to change code, documents behaviour, and catches regressions reliably.

The most commonly violated in kata work are:
- **D07 Behavioural** — testing mocks instead of outputs
- **D01 Isolated** — shared `before` state leaking between tests
- **D11 Predictive** — missing boundary values (exactly 1000, empty multi-delimiter)

## Project context

- **Language:** Ruby
- **Gems:** `rspec` only (`Gemfile`: `gem 'rspec'`)
- **Run tests:** `bundle exec rspec`
- **Format docs output:** `bundle exec rspec --format documentation`
- **Kata:** Roy Osherove String Calculator (Incubyte TDD Assessment)
