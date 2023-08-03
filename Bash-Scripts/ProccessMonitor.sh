#!/bin/bash

old_process=$(ps -eo cmd)

while true; do
    new_process=$(ps -eo cmd)
    diff -u <(echo "$old_process") <(echo "$new_process") | grep -v "procmon\|command"
    old_process=$new_process
done

