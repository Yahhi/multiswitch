# multiswitch

A Flutter widget library which shows the concept of switch with more then two values. 

[![Codemagic build status](https://api.codemagic.io/apps/5e2a14eb63c55e000d487bc2/5e2a14eb63c55e000d487bc1/status_badge.svg)](https://codemagic.io/apps/5e2a14eb63c55e000d487bc2/5e2a14eb63c55e000d487bc1/latest_build)

## Getting Started

To use it just add a dependency to this lib and then include in your widget in a similar way:
```
Multiswitch(
  options: ["one", "two", "three", "four", "five"],
  onChanged: _changeValue,
)
```

Listener which should fire on value changed shoul look like this:
```
void _changeValue(String value) {
  setState(() {
    this.value = value;
  });
}
```
