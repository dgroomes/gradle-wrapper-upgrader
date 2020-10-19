#!/usr/bin/env bash
#
# Upgrade the Gradle wrapper in the current directory and any recursive sub-directories that define a Gradle project. A
# Gradle project is identified as a directory that contains a 'settings.gradle' or 'settings.gradle.kts' file.

# Latest Gradle releases: https://gradle.org/releases/
# Set the version of Gradle to upgrade to (overridable via environment variable)
: ${GRADLE_VERSION:=6.7}

upgradeWrapperInDirectory() {

  set +u

  if [[ "x" == "$1x" ]]; then
    echo >&2 "A directory must be passed as the first argument to '${FUNCNAME[0]}' but found no args"
    exit
  fi

  set -u

  local directory="$1"
  local gradle_wrapper="$directory/gradlew"

  if [[ ! -d "$directory" ]]; then
    echo >&2 "'$directory' is not a directory"
    exit 1
  elif [[ ! -f "$gradle_wrapper" ]]; then
    echo >&2 "'$gradle_wrapper' file does not exist";
    exit 1
  elif [[ ! -x "$gradle_wrapper"  ]]; then
    echo >&2 "'$gradle_wrapper' file is not executable"
    exit 1
  fi

  echo "Upgrading the Gradle wrapper in $directory to version $GRADLE_VERSION"

  ./"$gradle_wrapper" --project-dir "$directory" wrapper --gradle-version $GRADLE_VERSION
}

set -eu

# Find all directories that appear to be a Gradle project
projects_string=$(find -E . -regex '.*/settings.gradle(.kts)?' -print0 |\
  xargs -0 -n1 dirname |\
  sort --unique)

# Extract the string into a Bash array
IFS=$'\n'
projects_array=( $projects_string )
unset IFS

for project in "${projects_array[@]}"; do
  upgradeWrapperInDirectory "$project"
done
