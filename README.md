## Introduction

conflict-sleuth.vim allows you to examine a gnarly merge conflict in multiple
tabs:

![](https://cdn-std.dprcdn.net/files/acc_68608/B4Zymb)

The first tab contains BASE and LOCAL files in the top half, diff'd against each
other.

The second tab contains BASE and REMOTE files in the top half, diff'd against
each other.

The lower half of each tab is the MERGED file that you write to in order to
resolve the conflict.

This plugin also adds syntax highlighting for an additional `conflict` filetype,
which the MERGED file is set to.

## Usage

The function `ConflictSleuth()` takes four arguments:
1. The Merged file
1. The Base File
1. The Local file
1. The Remote file

An easy way to set this up is to add this to your `.gitconfig`:

```gitconfig
[mergetool "conflict-sleuth"]

	cmd = vim -c \"ConflictSleuth $MERGED $BASE $LOCAL $REMOTE\"
	trustExitCode = false
```

When a conflict occurs, run `git mergetool -t conflict-sleuth`.

The function `CSRotateDiff()` changes which files in the current tab are diff'd
against each other -- BASE vs. LOCAL/REMOTE, BASE vs. MERGED, or LOCAL/REMOTE vs. MERGED.

The function `CSToggleFiller()` toggles whether Vim's diff options use filler
lines for missing text.

## Remaps

The following remaps are added by default:

- `<leader>d`: `CSRotateDiff()`
- `<leader>f`: `CSToggleFiller()`
