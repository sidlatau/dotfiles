vim.g["test#dart#fluttertest#executable"] = "fvm flutter test"
vim.cmd[[
let g:ultest_running_sign = ""
]]

-- TODO does not work yet but left for future
require("ultest").setup({
  builders = {
  ---@diagnostic disable-next-line: unused-local
    ["dart#fluttertest"] = function (cmd)
    return {
      dap = {
        type = 'dart',
        request = 'launch',
        dartSdkPath =".fvm/flutter_sdk/flutter/bin/cache/dart-sdk",
        flutterSdkPath = ".fvm/flutter_sdk",
        program = "${workspaceFolder}/lib/main.dart",
        cwd = "${workspaceFolder}",
      }
    }
    end
  }
})

