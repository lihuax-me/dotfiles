-- nvim-dap + dap-ui with GDB's built-in DAP (GDB >= 14 required)
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		-- 1) Core requires
		local dap = require("dap")
		local dapui = require("dapui")

		-- 2) UI setup
		dapui.setup()
		local set_hl = vim.api.nvim_set_hl
		set_hl(0, "DapBreakpointColor", { fg = "#fa4848" }) -- breakpoint red
		set_hl(0, "DapBreakpointCondColor", { fg = "#f6c244" }) -- yellow/orange
		set_hl(0, "DapBreakpointRejectedColor", { fg = "#a0a0a0" }) -- grey
		set_hl(0, "DapLogPointColor", { fg = "#4aa5f0" }) -- blue
		set_hl(0, "DapStoppedColor", { fg = "#3bd671" }) -- green
		vim.fn.sign_define("DapBreakpoint", {
			text = "",
			texthl = "DapBreakpointColor",
			linehl = "",
			numhl = "",
		})
		vim.fn.sign_define("DapBreakpointCondition", {
			text = "",
			texthl = "DapBreakpointCondColor",
			linehl = "",
			numhl = "",
		})
		vim.fn.sign_define("DapBreakpointRejected", {
			text = "",
			texthl = "DapBreakpointRejectedColor",
			linehl = "",
			numhl = "",
		})
		vim.fn.sign_define("DapLogPoint", {
			text = "",
			texthl = "DapLogPointColor",
			linehl = "",
			numhl = "",
		})
		vim.fn.sign_define("DapStopped", {
			text = "",
			texthl = "DapStoppedColor",
			linehl = "DapStoppedLine",
			numhl = "",
		})

		-- 3) Auto open/close UI on session start/stop
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- 4) Keymaps (normal mode)
		-- All comments are in English by request
		local map = vim.keymap.set
		map("n", "<leader>dc", dap.continue, { desc = "DAP Continue/Start" })
		map("n", "<leader>dt", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
		map("n", "<F33>", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
		map("n", "<C-F9>", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
		map("n", "<leader>dC", function() -- conditional breakpoint
			vim.ui.input({ prompt = "Condition: " }, function(cond)
				dap.set_breakpoint(cond)
			end)
		end, { desc = "DAP Conditional Breakpoint" })
		map("n", "<F9>", dap.continue, { desc = "DAP Continue" })
		map("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
		map("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
		-- map("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
		map("n", "<F12>", dap.run_to_cursor, { desc = "DAP Run to Cursor" })
		map("n", "<leader>dr", dap.restart, { desc = "DAP Restart" })
		map("n", "<leader>du", dapui.toggle, { desc = "DAP UI Toggle" })
		map("n", "<leader>de", dap.terminate, { desc = "DAP Terminate" })

		-- 5) GDB adapter (needs GDB >= 14 with DAP support)
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
		}

		-- 6) Shared configurations for C/C++/Rust
		local function pick_executable()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end

		local gdb_common = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = pick_executable,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false, -- set true to break at main()
				-- args = {},          -- e.g. { "arg1", "arg2" }
				-- env  = { VAR = "1"} -- pass environment variables
				-- sourceFileMap = { ["/remote/src"] = "${workspaceFolder}" } -- if needed
			},
			{
				name = "Select and attach to process",
				type = "gdb",
				request = "attach",
				program = pick_executable, -- needed for symbols
				pid = function()
					local name = vim.fn.input("Executable name (filter): ")
					return require("dap.utils").pick_process({ filter = name })
				end,
				cwd = "${workspaceFolder}",
			},
			{
				name = "Attach to gdbserver :1234",
				type = "gdb",
				request = "attach",
				target = "localhost:1234",
				program = pick_executable, -- must match the one running on the target
				cwd = "${workspaceFolder}",
			},
		}

		dap.configurations.c = gdb_common
		dap.configurations.cpp = gdb_common
		dap.configurations.rust = gdb_common -- for Rust you may prefer CodeLLDB
	end,
}
