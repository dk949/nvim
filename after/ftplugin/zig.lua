local function snippets()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local d = ls.dynamic_node
    local sn = ls.snippet_node
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
                "var gpa = std.heap.DebugAllocator(.{}).init;",
                "const alloc = gpa.allocator();",
                "defer _ = gpa.deinit();",
            })
        }),
        s({ trig = "DefA", desc = "Create a general purpose allocator" }, {
            t({
                [[const DefAlloc =]],
                [[    switch (@import("builtin").mode) {]],
                [[        .Debug, .ReleaseSafe => struct {]],
                [[            var gpa: std.heap.DebugAllocator(.{}) = .init;]],
                [[            pub fn allocator() std.mem.Allocator {]],
                [[                return gpa.allocator();]],
                [[            }]],
                [[            pub fn deinit() std.heap.Check {]],
                [[                return gpa.deinit();]],
                [[            }]],
                [[        },]],
                [[        .ReleaseFast, .ReleaseSmall => struct {]],
                [[            pub fn allocator() std.mem.Allocator {]],
                [[                return std.heap.smp_allocator;]],
                [[            }]],
                [[            pub fn deinit() std.heap.Check {]],
                [[                return .ok;]],
                [[            }]],
                [[        },]],
                [[    };]],
            })
        }),
        s({ trig = "def_a", desc = "Create a general purpose allocator" }, {
            t({
                "const alloc = DefAlloc.allocator();",
                "defer _ = DefAlloc.deinit();",
            })
        }),
        s({ trig = "arena", desc = "Create an arena allocator" }, {
            t({
                "var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);",
                "const alloc = arena.allocator();",
                "defer arena.deinit();",
            })
        })
    })
end

require "utils".ftplugin(
    require "config.common".prog:with {
        formatprg = require("config.common.formatting").zigPrg,
    },
    function()
        local log = require("utils.log")
        vim.system({ "zig", "env" }, { text = true }, function(out)
            if out.code ~= 0 or out.signal ~= 0 then
                log.sched.warn("Couldn't load zig environment: ", out.stderr)
                return
            end
            ---@type boolean, table
            local succ, res = pcall(vim.json.decode, out.stdout)
            if not succ then
                log.sched.warnf("Could not decode zig env: '%s'", out.stdout)
                return
            end
            ---@type string?
            local std_dir = res.std_dir
            if not std_dir then
                log.warn("Failed to read std_dir from ", res)
                return
            end
            vim.g.zig_std_dir = std_dir
        end)

        require "utils.lsp".enableLspTools({ config = "zls", mason = false }, {
            snippets = snippets
        })
    end
)
