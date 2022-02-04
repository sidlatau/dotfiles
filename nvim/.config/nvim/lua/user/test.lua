vim.g["test#dart#fluttertest#executable"] = "fvm flutter test"
vim.cmd [[
let g:ultest_running_sign = ""
]]

local success, dap = pcall(require, "dap")
if not success then
  return
end

-- TODO does not work yet but left for future
require("ultest").setup {
  builders = {
    ["dart#fluttertest"] = function(cmd)
      dap.adapters.dart = {
          type = "executable",
          command = "flutter",
          args = { "debug-adapter", "--test" },
      }
      dap.set_log_level('TRACE')
      print(vim.inspect(cmd))
      return {
        dap = {
          type = "dart",
          request = "launch",
          args = {cmd[#cmd], "--plain-name", cmd[5]},
        },
        parse_result = function(lines)
          print(vim.inspect(lines))
          return 1
        end
      }
    end,
  },
}
