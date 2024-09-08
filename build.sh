#!/usr/bin/env bash
sed s/{LINES}/$(($(wc -l <template.sh) + 1))/ <template.sh >sticker.webp
cat raw-sticker.png >>sticker.webp
