@echo off
setlocal enabledelayedexpansion
RD /S /Q temp
mkdir temp
cls
set sleep=500
set maxtime=10
set /p sleep=进程间隔【默认：%sleep%毫秒】:
set /p maxtime=单进程执行时间【默认：%maxtime%】秒:
echo WScript.sleep !sleep! > sleep.vbs
for /f "tokens=1,2" %%a in ('type "100个丢包最少的IP.txt"') do (
sleep.vbs
start /b curl --resolve apple.freecdn.workers.dev:443:%%a https://apple.freecdn.workers.dev/105/media/us/iphone-11-pro/2019/3bd902e4-0752-4ac1-95f8-6225c32aec6d/films/product/iphone-11-pro-product-tpl-cc-us-2019_1280x720h.mp4 -o temp/%%a -s --connect-timeout 2 --max-time !maxtime!
echo  正在测试 %%a
)
del sleep.vbs