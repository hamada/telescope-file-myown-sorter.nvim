-- original: https://github.com/natecraddock/telescope-zf-native.nvim/blob/beb34b6c48154ec117930180f257a5592606d48f/lua/telescope/_extensions/zf-native.lua
local sorters = require("telescope.sorters")

local make_sorter = function(opts)
    return sorters.new({
      start = function(self, prompt)
        -- vim.api.nvim_echo({ {tostring(prompt)} }, true, {})
        self.prompt = prompt
        -- self.tokens = zf.tokenize(prompt)
        -- self.case_sensitive = smart_case(prompt)
      end,
      scoring_function = function(self, _, line)
        -- vim.api.nvim_echo({ {tostring(self.tokens.tokens)} }, true, {})
        -- vim.api.nvim_echo({ {line} }, true, {})
        -- smaller number is higher (0 ~ 1)

        if self.prompt ~= '' then
          if string.find(line, self.prompt) ~= nil then
            return 0
          else
            -- if not matched, exclude it from results by returning -1
            return -1
          end
        end

        first_char = string.sub(line, 1, 1)
        if first_char == '.' then
          -- dotfiles
          return 1
        else
          -- not dotfiles
          -- return bigger number if line comes first in alphabetical order
          -- vim.api.nvim_echo({ {first_char} }, true, {})

          dictionary = { a = 1, b = 2, c = 3, d = 4, e = 5, f = 6, g = 7, h = 8, i = 9, j = 10, k = 11, l = 12, m = 13, n = 14, o = 15, p = 16, q = 17, r = 18, s = 19, t = 20, u = 21, v = 22, w = 23, x = 24, y = 25, z = 26, A = 27, B = 28, C = 29, D = 30, E = 31, F = 32, G = 33, H = 34, I = 35, J = 36, K = 37, L = 38, M = 39, N = 40, O = 41, P = 42, Q = 43, R = 44, S = 45, T = 46, U = 47, V = 48, W = 49, X = 50, Y = 51, Z = 52, }

          position = (dictionary[first_char] or 52) / 52
          return position
        end
      end,
    })
end

return require("telescope").register_extension({
    setup = function(ext_config, tele_config)
        tele_config.file_sorter = function()
            return make_sorter({ enable = true, highlight_results = true, match_filename = true })
        end
    end,
})
