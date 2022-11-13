local typedefs = require "kong.db.schema.typedefs"

return {
    name = "custom-auth",
    fields = { {
        protocols = typedefs.protocols_http
    }, {
        consumer = typedefs.no_consumer
    }, {
        config = {
            type = "record",
            fields = { {
                introspection_endpoint = typedefs.url({
                    default = "http://authz/auth/validate",
                    required = true
                })
            }, {
                path_prefix = typedefs.path({
                    required = false
                })
            }, {
                allow_headers = {
                    type = "array",
                    required = false,
                    elements = typedefs.header_name,
                    default = { "x-user-id", "x-user-role", "x-service", "x-payload" }
                }
            }, {
                token_header = typedefs.header_name {
                    default = "Authorization",
                    required = true
                }
            } }
        }
    } }
}
