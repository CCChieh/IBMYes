@echo off
set a=1.0.0.1
set /p a=请输入 IP【默认：%a%】
title  正在测试 %a%
curl --resolve apple.freecdn.workers.dev:443:%a% https://apple.freecdn.workers.dev/105/media/us/iphone-11-pro/2019/3bd902e4-0752-4ac1-95f8-6225c32aec6d/films/product/iphone-11-pro-product-tpl-cc-us-2019_1280x720h.mp4 -o nul --connect-timeout 5
