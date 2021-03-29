# gradle-wrapper-upgrader

🛠 Simple convenience script for upgrading a project's Gradle wrapper.

---
**NOTE**:

This was developed on macOS and for my own personal use.

---

### Installation

Clone this repo and then consider symlinking the script to a directory that's on your `PATH`. For example:

```
ln -s "$PWD/upgrade-gradle-wrapper.sh" /usr/local/bin/
```

### Usage

In the root directory of a Gradle project, execute

```
upgrade-gradle-wrapper.sh
```

Optionally, execute the script and also specify the Gradle version explicitly via an environment variable:

```
GRADLE_VERSION=7.0-rc-1 upgrade-gradle-wrapper.sh
```

### Materials Referenced

* <https://gist.github.com/dgroomes/3bfe7f24670e74ee814a7f8e3956cce6>
