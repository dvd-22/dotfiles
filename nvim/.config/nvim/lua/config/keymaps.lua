-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Toggle Copilot (enable/disable) with <leader> a c
local function toggle_copilot()
	local enabled = vim.g.copilot_enabled
	if enabled == nil then
		-- assume enabled by default if unset
		enabled = true
	end

	local function notify(msg)
		vim.notify(msg, vim.log.levels.INFO, {title = "Copilot"})
	end

	if enabled then
		-- try command first (works with copilot.vim and copilot.lua which expose :Copilot)
		if vim.fn.exists(":Copilot") == 2 then
			pcall(vim.cmd, "Copilot disable")
			vim.g.copilot_enabled = false
			notify("disabled")
			return
		end

		-- try Lua module API (best-effort; may vary by plugin)
		local ok, suggestion = pcall(require, "copilot.suggestion")
		if ok and suggestion and type(suggestion.disable) == "function" then
			pcall(suggestion.disable)
			vim.g.copilot_enabled = false
			notify("disabled")
			return
		end

		-- fallback: set flag and inform user
		vim.g.copilot_enabled = false
		notify("disabled (best-effort; plugin command/API not found)")
	else
		if vim.fn.exists(":Copilot") == 2 then
			pcall(vim.cmd, "Copilot enable")
			vim.g.copilot_enabled = true
			notify("enabled")
			return
		end

		local ok, suggestion = pcall(require, "copilot.suggestion")
		if ok and suggestion and type(suggestion.enable) == "function" then
			pcall(suggestion.enable)
			vim.g.copilot_enabled = true
			notify("enabled")
			return
		end

		vim.g.copilot_enabled = true
		notify("enabled (best-effort; plugin command/API not found)")
	end
end

vim.keymap.set("n", "<leader>ac", toggle_copilot, {desc = "Toggle Copilot (enable/disable)"})
