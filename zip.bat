@echo off
set /P directory="Enter directory (example: debug/hl): "

echo Moving to directory: "export/%directory%/bin/"
cd "export/%directory%/bin/"

echo Zipping directory:
wsl zip -r Onrev *

echo Moving to export...
wsl mv Onrev.zip ../../../../export/