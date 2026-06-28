-- Luacheck config for dotfiles (Neovim + WezTerm Lua configs).
-- Lenient on purpose: this is editor config, not application code, so we keep
-- only the high-signal checks (undefined globals, syntax, accidental shadowing)
-- and silence style noise that would otherwise flood the report.

std = "luajit"

-- Globals injected by the host runtimes.
read_globals = {
	"vim", -- Neovim
	"wezterm", -- WezTerm (also required as a module, but kept for safety)
}

-- Only lint our own configs; third-party plugins are cloned at runtime and
-- are not committed, but exclude defensively in case they exist locally.
include_files = {
	"nvim/.config/nvim/**/*.lua",
	"wezterm/.config/wezterm/**/*.lua",
}
exclude_files = {
	"**/plugins/**",
	"**/pack/**",
	"**/lazy/**",
}

-- Editor config churns a lot of intentionally-unused locals/args; keep the
-- signal on undefined globals and real mistakes, not housekeeping.
unused = false
unused_args = false
max_line_length = false
ignore = {
	"542", -- empty if branch (common in config guards)
}
