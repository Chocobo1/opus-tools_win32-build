@echo off

opusenc.exe --bitrate 32  --vbr --comp 10 --quiet in.wav - > nul
opusenc.exe --bitrate 64  --vbr --comp 10 --quiet in.wav - > nul
opusenc.exe --bitrate 96  --vbr --comp 10 --quiet in.wav - > nul
opusenc.exe --bitrate 128 --vbr --comp 10 --quiet in.wav - > nul
opusenc.exe --bitrate 160 --vbr --comp 10 --quiet in.wav - > nul

rem pgomgr /merge opusenc.pgd
