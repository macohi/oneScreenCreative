@echo off
set /P directory="Enter directory (example: debug/hl): "
set /P suffix="Enter file suffix (example: z1-hashlink): "

echo Moving to directory: "export/%directory%/bin/"
cd "export/%directory%/bin/"

echo Zipping directory into "Onrev_%suffix%.zip":
wsl zip -r "Onrev_%suffix%.zip" *

echo Moving to export...
wsl mv "Onrev_%suffix%.zip" ../../../../export/