# String Calculator Kata

A simple Ruby project built using **Test-Driven Development (TDD)**.

## TDD Cycle

This project follows the classic:

```text
Red → Green → Refactor
```

- 🔴 **Red** → write a failing test
- 🟢 **Green** → write minimum code to pass
- 🔵 **Refactor** → improve code without changing behavior

Example commit flow:

```bash
red: add failing test for custom delimiter
green: support custom delimiter
refactor: simplify delimiter parsing
```

---

## Features

✅ Empty string returns `0`  
✅ Supports comma and newline delimiters  
✅ Supports custom delimiters  
✅ Raises error for negative numbers  
✅ Ignores numbers greater than `1000`  
✅ Supports multi-character delimiters  
✅ Supports multiple delimiters  
✅ Tracks add method calls  

---

## Examples

```ruby
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

## Run Project

Install dependencies:

```bash
bundle install
```

Run tests:

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

---

## Resources

- http://osherove.com/kata
- Test Driven Development by Kent Beck