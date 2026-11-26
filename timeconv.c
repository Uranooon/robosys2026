// SPDX-FileCopyrightText: 2026 Haruto Urano
// SPDX-License-Identifier: BSD-3-Clause
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[])
{
    long long seconds;
    long long hours;
    int minutes;
    int remaining_seconds;

    // 逆変換
    if (argc == 2 && strcmp(argv[1], "-r") == 0) {
        int h, m, s;
        char extra;

        if (scanf("%d %d %d %c", &h, &m, &s, &extra) != 3) {
            fprintf(stderr, "入力エラー\n");
            return 1;
        }

        if (h < 0 || m < 0 || m >= 60 ||
            s < 0 || s >= 60) {
            fprintf(stderr, "入力範囲エラー\n");
            return 1;
        }

        seconds = (long long)h * 3600 + m * 60 + s;
        printf("%lld\n", seconds);

        return 0;
    }

    // 通常変換
    if (argc != 1) {
        fprintf(stderr, "オプションエラー\n");
        return 1;
    }

    if (scanf("%lld", &seconds) != 1) {
        fprintf(stderr, "入力エラー\n");
        return 1;
    }

    if (seconds < 0) {
        fprintf(stderr, "秒数は0以上で入力してください\n");
        return 1;
    }

    hours = seconds / 3600;
    minutes = (seconds % 3600) / 60;
    remaining_seconds = seconds % 60;

    printf("%lld時間%d分%d秒\n",
           hours, minutes, remaining_seconds);

    return 0;
}
