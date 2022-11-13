local http = require "resty.http"
-- local utils = require "kong.tools.utils"

local TokenHandler = {
    VERSION = "1.0",
    PRIORITY = 1000
}

local function introspect_access_token(conf, authorization_header, request_path)
    local httpc = http:new()
    local res, err = httpc:request_uri(conf.path_prefix and conf.introspection_endpoint .. conf.path_prefix ..
        request_path or conf.introspection_endpoint .. request_path, {
        method = "POST",
        body = "path=" .. request_path .. "&token=" .. authorization_header,
        ssl_verify = false,
        headers = {
            ["Content-Type"] = "application/x-www-form-urlencoded",
            ["Authorization"] = authorization_header
        }
    })

    if not res then
        kong.log.err("failed to call introspection endpoint: ", err)
        return kong.response.exit(500)
    end
    if res.status == 401 then
        kong.response.exit(401)
    else
        if res.status ~= 200 then
            kong.log.err("introspection endpoint responded with status: ", res.status)
            local body, err = res:read_body()
            if err then
                kong.log.err("introspection endpoint responded with error: ", err)
            end
            return kong.response.exit(500)
        end
        -- lặp từ 1-4 allow_headers => bắt buộc phải đúng 4 allow_headers, nếu k sẽ gặp lỗi, nếu cấu hình nhiều hơn hay ít hơn thì phải thay đổi chỗ này
        for i = 1, 4 do
            local header_name = conf.allow_headers[i];
            local data = res.headers[header_name]
            if data then
                kong.service.request.set_header(header_name, data)
            end
        end
        return true -- all is well
    end

end

function TokenHandler:access(conf)
    local authorization_header = ngx.req.get_headers()[conf.token_header]
    -- if not authorization_header then
    --     kong.log.err("token not found")
    --     kong.response.exit(401) -- unauthorized
    -- end
    if not authorization_header then
        authorization_header = ""
    end
    -- authorization_header = authorization_header:sub(8, -1) -- drop "Bearer "
    local request_path = ngx.var.request_uri

    introspect_access_token(conf, authorization_header, request_path)

    kong.service.request.clear_header(conf.token_header)
end

return TokenHandler
