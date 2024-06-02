local source = {}

local function get_filenames(path, extractor)
    if path == '' or not path then
        return {}
    end

    -- extracting the last part of a path
    local path_parts = vim.split(path, '/')
    local filename = path_parts[#path_parts]

    if not filename or filename == '' then
        return {}
    end

    -- splitting it with '.' to drop an extension and scopes (filename.scope.extension)
    return extractor and extractor(filename, path) or { filename:match '[^.]*' }
end

function source:complete(params, callback)
    local opts = params.option or {}

    if opts.current_buf_only then
        local filenames = get_filenames(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), opts.extractor)

        local entries_set = {}
        local entries = {}

        for _, filename in ipairs(filenames) do
            if filename ~= '' and not entries_set[filename] then
                table.insert(entries, { label = filename })
                entries_set[filename] = true
            end
        end

        callback(entries)

        return
    end

    local bufs = opts.bufs and opts.bufs() or vim.api.nvim_list_bufs()

    -- table of filenames that already been set to prevent duplicating
    local entries_set = {}
    local entries = {}

    for _, buf_id in ipairs(bufs) do
        local filenames = get_filenames(vim.api.nvim_buf_get_name(buf_id), opts.extractor)

        for _, filename in ipairs(filenames) do
            if filename ~= '' and not entries_set[filename] then
                table.insert(entries, { label = filename })
                entries_set[filename] = true
            end
        end
    end

    callback(entries)
end

function source.new()
    return setmetatable({}, { __index = source })
end

return source
