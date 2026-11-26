#!/bin/bash
# SPDX-FileCopyrightText: 2026 Haruto Urano
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo "テスト失敗: $1" >&2
    res=1
}

res=0

# 秒から時間・分・秒への変換
out=$(echo 3725 | ./timeconv)
[ "$out" = "1時間2分5秒" ] || ng "通常変換"

# 1時間への変換
out=$(echo 3600 | ./timeconv)
[ "$out" = "1時間0分0秒" ] || ng "3600秒の変換"

# 分・秒への変換
out=$(echo 90 | ./timeconv)
[ "$out" = "0時間1分30秒" ] || ng "90秒の変換"

# 時間・分・秒から秒への逆変換
out=$(echo "1 2 5" | ./timeconv -r)
[ "$out" = "3725" ] || ng "逆変換"

# 負の数の入力
echo "-10" | ./timeconv >/dev/null 2>&1
[ $? -ne 0 ] || ng "負の数の拒否"

# 不正な入力
echo "abc" | ./timeconv >/dev/null 2>&1
[ $? -ne 0 ] || ng "不正な入力の拒否"

# 0秒の変換
out=$(echo 0 | ./timeconv)
[ "$out" = "0時間0分0秒" ] || ng "0秒の変換"

# 59秒の変換
out=$(echo 59 | ./timeconv)
[ "$out" = "0時間0分59秒" ] || ng "59秒の変換"

# 60秒の変換
out=$(echo 60 | ./timeconv)
[ "$out" = "0時間1分0秒" ] || ng "60秒の変換"

# 逆変換で不正な分を拒否
echo "1 60 0" | ./timeconv -r >/dev/null 2>&1
[ $? -ne 0 ] || ng "不正な分の拒否"

# 逆変換で不正な秒を拒否
echo "1 0 60" | ./timeconv -r >/dev/null 2>&1
[ $? -ne 0 ] || ng "不正な秒の拒否"

[ "$res" = 0 ] && echo "OK"
exit "$res"