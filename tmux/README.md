# `tmux`

`tmux` is a terminal multiplexer.

## Shell command quirks

Shell commands in `tmux` configuration are run via `/bin/sh -c`.  The shell
located at `/bin/sh` often varies between *nix systems. Adhering to POSIX
compliance scripting is ideal for portability.

Shell scripting that requires sequential command execution can be achieved using
semicolon separation. For instance:

```sh
if true; then echo "case A"; else echo "case B"; fi
```

Additionally, readability can be improved using backslashes for line continuation:

```sh
if true; then \
    echo "case A"; \
else \
    echo "case B"; \
fi
```

### Writing comments

The typical methodology of using a number sign (`#`) to write a comment within a
shell script is incompatible with sequential command execution.

Instead, comment-like messages can be written by utilizing the special built-in
`:` ("colon null utility"). The "colon null utility" has no effect, which makes
it suitable for this use case:

```sh
: " \:
Display a salutation \
"; \
echo "Hello world"; \
\
: " \
Create directory for photographs \
"; \
mkdir -p /tmp/my-photos/
```
