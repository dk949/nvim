-- XXX: This function has to be defined in a file named cpp.lua.
--      Otherwise snippets might be added multiple times or not at all!
local function snippets()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    ls.filetype_extend("cpp", { "cppdoc" })
    ls.add_snippets("cpp", {
        s({ trig = "#incrng", desc = "include `std::chrono`, add namespace alias and literals" }, {
            t({
                [[#include <ranges>]],
                [[namespace rng = std::ranges;]],
                [[namespace vws = std::views;]],
            })
        }),
        s({ trig = "#incchr", desc = "include `std::chrono`, add namespace alias and literals" }, {
            t({
                [[#include <chrono>]],
                [[namespace chr = std::chrono;]],
                [[using namespace std::chrono_literals;]],
            })
        }),
        s({ trig = "#incstr", desc = "include `std::string` and add literals" }, {
            t({
                [[#include <string>]],
                [[using namespace std::string_literals;]],
            })
        }),
        s({ trig = "#incstrv", desc = "include `std::string_view`and add literals" }, {
            t({
                [[#include <string_view>]],
                [[using namespace std::string_view_literals;]],
            })
        }),
        s({ trig = "#incfs", desc = "include `std::filesystem` and add namespace alias" }, {
            t({
                [[#include <filesystem>]],
                [[namespace fs = std::filesystem;]],
            })
        }),
        s({ trig = "cfmt", desc = "clang format pragma" }, {
            t("// clang-format "),
            i(1, "off"),
        }),
    })
end

require "utils".ftplugin(
    require "config.common".prog,
    function()
        require "utils.lsp".enableLspTools("clangd", { snippets = snippets })
    end
)
