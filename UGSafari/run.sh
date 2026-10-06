#!/usr/bin/env bash
set -eu
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$PROJECT_DIR"
mkdir -p bin

# Collect sources without process substitution (portable)
JAVA_FILES=$(find src -name '*.java' 2>/dev/null || true)
if [ -z "$JAVA_FILES" ]; then
  echo "No .java files found under src/" >&2
  exit 1
fi

CP="bin"
if [ -d lib ]; then
  for jar in lib/*.jar; do
    [ -f "$jar" ] && CP="$CP:$jar"
  done
fi

echo "Compiling project..."
# shellcheck disable=SC2086
javac -d bin -sourcepath src -cp "$CP" $JAVA_FILES
echo "Running..."
echo "--------------------------"
java -cp "$CP" com.ugsafari.Main
echo "--------------------------"
echo "(process exited — close this terminal with :q or sc)"
