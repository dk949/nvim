local initialised = {}




return function(lang)
    if initialised[lang] then return end
    initialised[lang] = true

    local ls = require("luasnip")
    local s = ls.snippet
    local sn = ls.snippet_node
    local isn = ls.indent_snippet_node
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node
    local d = ls.dynamic_node
    local r = ls.restore_node
    local events = require("luasnip.util.events")
    local ai = require("luasnip.nodes.absolute_indexer")
    local extras = require("luasnip.extras")
    local l = extras.lambda
    local rep = extras.rep
    local p = extras.partial
    local m = extras.match
    local n = extras.nonempty
    local dl = extras.dynamic_lambda
    local fmt = require("luasnip.extras.fmt").fmt
    local fmta = require("luasnip.extras.fmt").fmta
    local conds = require("luasnip.extras.expand_conditions")
    local postfix = require("luasnip.extras.postfix").postfix
    local types = require("luasnip.util.types")
    local parse = require("luasnip.util.parser").parse_snippet
    local ms = ls.multi_snippet
    local k = require("luasnip.nodes.key_indexer").new_key

    local snips = {
        all = function() end,
        mail = function() ls.filetype_extend("mail", { "html" }) end,
        cpp = function()
            ls.filetype_extend("cpp", { "cppdoc" })
            ls.add_snippets("cpp", {
                s({ trig = "incchr", desc = "include `std::chrono`, add namespace alias and literals" }, {
                    t({
                        [[#include <chrono>]],
                        [[namespace chr = std::chrono;]],
                        [[using namespace std::chrono_literals;]],
                    })
                }),
                s({ trig = "incstr", desc = "include `std::string` and add literals" }, {
                    t({
                        [[#include <string>]],
                        [[using namespace std::string_literals;]],
                    })
                }),
                s({ trig = "incstrv", desc = "include `std::string_view`and add literals" }, {
                    t({
                        [[#include <string_view>]],
                        [[using namespace std::string_view_literals;]],
                    })
                }),
                s({ trig = "incfs", desc = "include `std::filesystem` and add namespace alias" }, {
                    t({
                        [[#include <filesystem>]],
                        [[namespace fs = std::filesystem;]],
                    })
                }),
            })
        end,
        zig = function()
            ls.add_snippets("zig", {
                s({ trig = "panic", desc = "Add a debug panic statement" }, {
                    t([[std.debug.panic("]]),
                    i(1),
                    t([[", .{]]),
                    i(2),
                    t([[});]]),
                }),
                s({ trig = "assert", desc = "Add a debug assert statement" }, {
                    t([[std.debug.assert(]]),
                    i(1),
                    t([[);]]),
                }),
                s({ trig = "builtin", desc = "Import the builtin module" }, {
                    t([[const builtin = @import("builtin");]])
                }),
                s({ trig = "This", desc = "Add `const CurrnetFile = @This();`" }, {
                    t("const "),
                    d(1, function() return sn(1, { i(1, vim.fs.basename(vim.fn.expand("%:r"))) }) end),
                    t(" = @This();"),
                }),
                s({ trig = "gpa", desc = "Create a general purpose allocator" }, {
                    t({
                        "var gpa = std.heap.GeneralPurposeAllocator(.{}){};",
                        "const alloc = gpa.allocator();",
                        "defer _ = gpa.deinit();",
                    })

                })
            })
        end
    }
    if snips[lang] then snips[lang]() end
    if snips.all then snips.all() end
end
