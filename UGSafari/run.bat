@echo off
setlocal EnableDelayedExpansion
cd /d "%~dp0"
if not exist bin mkdir bin

set "JAVA_FILES="
for /r src %%f in (*.java) do set "JAVA_FILES=!JAVA_FILES! "%%f""

if "!JAVA_FILES!"=="" (
  echo No .java files found under src\
  exit /b 1
)

set "CP=bin"
if exist lib\ (
  for %%j in (lib\*.jar) do set "CP=!CP!;%%j"
)

echo Compiling project...
javac -d bin -sourcepath src -cp "!CP!" !JAVA_FILES!
if errorlevel 1 (
  echo Compilation failed.
  exit /b 1
)
echo Running...
echo --------------------------
java -cp "!CP!" com.ugsafari.Main
echo --------------------------
echo (process exited — close this terminal with :q or sc)
