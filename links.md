# Cmark and GFM

- [A formal spec for GitHub Flavored Markdown](https://githubengineering.com/a-formal-spec-for-github-markdown)
- [GitHub's fork of cmark, a CommonMark parsing and rendering library and program in C](https://github.com/github/cmark)
- [GitHub Flavored Markdown Spec](https://github.github.com/gfm)

# Googler

- [Google Search, Google Site Search, Google News from the terminal](https://github.com/jarun/googler)

# Enchive 

- [Enchive : encrypted personal archives](https://github.com/skeeto/enchive)
- [Why I've Retired My PGP Keys and What's Replaced It](http://nullprogram.com/blog/2017/03/12/)

# Ansi color for emacs shell

- [Emacs Wiki Ansi Color](https://www.emacswiki.org/emacs/AnsiColor)

```lisp
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

```

```bash
export TERM=eterm-color
```
