return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		dap.adapters.lldb = {
			type = "executable",
			command = "/opt/homebrew/opt/llvm/bin/lldb-dap",
			name = "lldb",
		}

		dap.configurations.c = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},

				-- 💀
				-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
				--
				--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
				--
				-- Otherwise you might get the following error:
				--
				--    Error on launch: Failed to attach to the target process
				--
				-- But you should be aware of the implications:
				-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
				-- runInTerminal = false,
			},
		}

		local dapui = require("dapui")

		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end

		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- Keymaps
        local keymap = vim.keymap
		keymap.set("n", "<leader>dc", function() dap.continue() end)
		keymap.set("n", "<leader>dn", function() dap.step_over() end)
		keymap.set("n", "<leader>di", function() dap.step_into() end)
		keymap.set("n", "<leader>do", function() dap.step_out() end)
		keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end)
	    keymap.set("n", "<leader>dT", function() dap.terminate() end)
		keymap.set("n", "<Leader>lp", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end)
		keymap.set("n", "<Leader>dr", function() dap.repl.open() end)
		keymap.set("n", "<Leader>dl", function() dap.run_last() end)
	end,
}
