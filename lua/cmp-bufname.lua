local source = {}

local function extract_filename(path)
    if path == '' or not path then
        return ''
    end

    -- extracting the last part of a path
    local path_parts = vim.split(path, '/')
    local filename = path_parts[#path_parts]

    if not filename or filename == '' then
        return ''
    end

    -- splitting it with '.' to drop an extension and scopes (filename.scope.extension)
    return filename:match '[^.]*'
end

function source:complete(params, callback)
    if params.option and params.option.current_buf_only then
        local filename = extract_filename(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))

        if filename ~= '' then
            callback { { label = filename } }
        end

        return
    end

    local bufs = vim.api.nvim_list_bufs()

    local filenames_set = {}

    local filenames_response = {}

    for _, buf_id in ipairs(bufs) do
        local filepath = vim.api.nvim_buf_get_name(buf_id)

        local filename = extract_filename(filepath)

        if filename ~= '' and not filenames_set[filename] then
            table.insert(filenames_response, { label = filename })
        end
    end

    callback(filenames_response)
end

function source.new()
    return setmetatable({}, { __index = source })
end

return source
