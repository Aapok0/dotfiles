#! /usr/bin/env sh

git config --get-regexp 'alias' | awk '{gsub(/alias\./, "git "); print}' | awk '{$2 = $2 " ="; print}'
