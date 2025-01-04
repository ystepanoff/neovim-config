#!/bin/zsh

PYTHONPATH=$HOME/.config/nvim/lua/configs/lint/pylint-plugins/ pylint --load-modules=async_await_checker -f json --from-stdin $1
