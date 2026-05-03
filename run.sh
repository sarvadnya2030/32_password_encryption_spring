#!/bin/bash
DIR="$(dirname "$0")"
PORT=${PORT:-8080}

if [[ "$OSTYPE" == "darwin"* ]]; then
  JAVA=$(/usr/libexec/java_home -v 21 2>/dev/null)/bin/java
else
  JAVA=$(ls /usr/lib/jvm/java-21*/bin/java 2>/dev/null | head -1)
fi
JAVA=${JAVA:-java}

JAR=$(ls "$DIR"/target/*.jar 2>/dev/null | grep -v original | head -1)
if [ -z "$JAR" ]; then echo "No JAR found. Run: mvn package -DskipTests"; exit 1; fi

echo "Starting → http://localhost:$PORT"
echo "Press Ctrl+C to stop."
"$JAVA" -jar "$JAR" --server.port=$PORT
