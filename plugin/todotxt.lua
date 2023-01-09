local function fieldValue(t, val, eq)
    if t == nil then return nil end
    if t[val] == nil then return nil end
    if eq ~= nil then return t[val] == eq end
    return t[val]
end

local function dateFromStr(str)
    local p = "(%d%d%d%d)-(%d%d)-(%d%d)"
    local year, month, day = str:match(p)
    return os.time({ year = year, month = month, day = day })
end

require('todotxt-nvim').setup(
    {
        todo_file = "~/Documents/Todo/todo.txt",
        sidebar = {
            width = 60,
            position = "right",
        },
        highlights = {
            project = {
                fg = "magenta",
                bg = "NONE",
                style = "NONE",
            },
            context = {
                fg = "cyan",
                bg = "NONE",
                style = "NONE",
            },
            date = {
                fg = "NONE",
                bg = "NONE",
                style = "underline",
            },
            done_task = {
                fg = "gray",
                bg = "NONE",
                style = "NONE",
            },
            priorities = {
                A = {
                    fg = "red",
                    bg = "NONE",
                    style = "bold",
                },
                B = {
                    fg = "yellow",
                    bg = "NONE",
                    style = "italic",
                },
                C = {
                    fg = "green",
                    bg = "NONE",
                    style = "NONE",
                },
                D = {
                    fg = "cyan",
                    bg = "NONE",
                    style = "NONE",
                },
            },
        },
        -- Keymap used in sidebar split
        keymap = {
            quit = "q",
            toggle_metadata = "m",
            delete_task = "dd",
            complete_task = "<space>",
            edit_task = "i",
        },

        -- Task.completion_date
        -- Task.contexts
        -- Task.creation_date
        -- Task.done
        -- Task.kv
        -- Task.priority
        -- Task.projects
        -- Task.text
        taskDisplayHook = function(task)
            if fieldValue(task.kv, 'h', '1') then
                return nil -- hide hidden tasks
            elseif task.priority == 'Z' then
                return nil -- hide tasks with low priority
            elseif fieldValue(task.kv, 't') then
                if os.difftime(dateFromStr(task.kv.t), os.time()) <= 0 then
                    return task
                else
                    return nil -- hide tasks with threashold date in the future
                end
            else
                return task
            end
        end
    }
)
