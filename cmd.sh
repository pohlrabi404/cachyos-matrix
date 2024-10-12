#!/usr/bin/env bash
cat | sudo tee /etc/keyd/default.conf << EOF
[ids]

*

[main]
muhenkan = oneshot(meta)
control = oneshot(control)

leftalt = oneshot(alt)
capslock = overload(control, esc)
EOF
