# String Calculator Kata

A Ruby implementation of the String Calculator Kata built using strict Test-Driven Development (TDD).

This project was completed by following the Red → Green → Refactor cycle with very small commits and incremental behavior changes.

---

## TDD Approach

This project follows the classic TDD workflow:

```text
Red → Green → Refactor
```

- 🔴 **Red** → write a failing test
- 🟢 **Green** → write the minimum code needed to pass
- 🔵 **Refactor** → improve the implementation without changing behavior

Each feature was implemented one failing test at a time with small commits after every cycle.

Example commit flow:

```bash
red: add failing test for empty string
green: return 0 for empty string
refactor: simplify add method
```

---

## Features Implemented

✅ Empty string returns `0`  
✅ Single number returns its value  
✅ Supports comma-separated numbers  
✅ Supports newline delimiters  
✅ Supports custom delimiters  
✅ Raises exception for negative numbers  
✅ Ignores numbers greater than `1000`  
✅ Supports multi-character delimiters  
✅ Supports multiple delimiters  
✅ Tracks add method calls  

---

## Examples

```ruby
calculator.add("")
# => 0

calculator.add("1")
# => 1

calculator.add("1,2,3")
# => 6

calculator.add("1\n2,3")
# => 6

calculator.add("//;\n1;2")
# => 3

calculator.add("//[***]\n1***2***3")
# => 6

calculator.add("//[*][%]\n1*2%3")
# => 6
```

---

## Project Structure

```text
.
├── lib
│   └── string_calculator.rb
├── spec
│   └── string_calculator_spec.rb
├── Gemfile
├── README.md
└── .gitignore
```

---

## Setup Instructions

### Clone Repository

```bash
git clone https://github.com/YOUR_USERNAME/string-calculator-kata.git
cd string-calculator-kata
```

### Install Dependencies

```bash
bundle install
```

### Run Tests

```bash
bundle exec rspec
```

---

## Test Cases Covered

- Empty string
- Single number
- Multiple numbers
- Newline delimiters
- Custom delimiters
- Negative numbers
- Ignore numbers greater than `1000`
- Multi-character delimiters
- Multiple delimiters
- Method call tracking

---

## Strict TDD Workflow

This kata was intentionally implemented using strict TDD discipline:

- One failing test at a time
- Minimal implementation only
- Refactor only after tests pass
- Small focused commits
- No implementation ahead of tests

---

## Pairing with Claude Code — Holding the Line

While pairing with Claude Code during this kata, the biggest challenge was preventing the AI from jumping ahead of the current failing test.

In strict TDD, each step should only solve the immediate red test with the minimum possible code. Claude Code frequently tried to anticipate future requirements and generate larger implementations than necessary.

For example, while writing a test for:

```ruby
calculator.add("")
# => 0
```

the AI would attempt to introduce:
- delimiter parsing
- newline handling
- negative number validation
- generalized parsing logic

even though none of those behaviors were required by the current failing test.

The discipline that worked was repeatedly enforcing:

> "Only write the minimum code needed to make the current failing test pass."

Sometimes this meant stopping the generation midway and reverting changes that went beyond the current scope.

This exercise reinforced an important lesson:

AI-assisted TDD still requires strong human control over scope, pacing, and incremental design decisions.

The value of the kata was not just solving the problem, but practicing how to protect the Red → Green → Refactor cycle while pairing with an AI assistant.

---

## Resources

- http://osherove.com/kata
- Kent Beck — *Test-Driven Development: By Example*
- Incubyte TDD Assessment Guidelines

---

## Repository

Replace with your repository link:

```text
https://github.com/nishantkadam-dev/string-calculator-kata
```