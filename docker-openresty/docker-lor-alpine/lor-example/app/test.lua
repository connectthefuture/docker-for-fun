local sgsub = ngx.re.gsub
local smatch = ngx.re.match
local function tappend(t, v) t[#t+1] = v end


-- pattern或是uri末尾为n个/，均忽略
local _M = {}

-- 去除多余的/
function _M.clear_slash(s)
    s, _ = sgsub(s, "(/+)", "/", "io")
    return s
end
--
function _M.parse_pattern(path, keys, options)
    path = _M.clear_slash(path)

    local new_pattern = sgsub(path, "/:([A-Za-z0-9_-]+)", function(m)
    	if m and type(m) == 'table' then
    		-- for i, v in pairs(m) do
    		-- 	ngx.say(i .. " * ".. v)
    		-- end
        	tappend(keys, m[1])
        end

        return "/([A-Za-z0-9_-]+)"
    end, "io")

    -- 以*结尾
    local all_pattern = sgsub(new_pattern, "/[%*]+", function(m)
        return "/(.*)" -- "/(.)"
    end, "io")
    return all_pattern
end

function _M.parse_path(uri, pattern, keys)
    uri = _M.clear_slash(uri)

    local params = {}
    local match, err =  smatch(uri, pattern)  -- match is nil or array, param values 
    if match then
    	for j = 1, #match do 
    		if match[j] then
    			local param_name = keys[j]
    			if param_name then 
    				params[param_name] = match[j]
    			end
    		end
    	end
    else
    	if err then
			ngx.log(ngx.ERR, "parse_path error: ", uri, " " , pattern)
    	end
    	return params
    end

    return params
end

function _M.is_match(uri, pattern)
	if not uri or not pattern then 
		return false
	end

    local ok, err = smatch(uri, pattern, "io")
    if ok then 
    	-- for i,v in ipairs(ok) do
    	-- 	ngx.say(#ok , " ", ok[0] .. " " .. i .. " |-> " .. v)
    	-- end

    	return true
    else
    	if err then 
    		ngx.log(ngx.ERR, "is_match error: ", uri, " ", pattern, " ",  err)
	    end
    	return false
    end
end

-- local keys = {}
-- local pattern = _M.parse_pattern("/todo/:filter/:abc", keys)
-- ngx.say(type(keys), " pattern ", pattern)

-- for i,j in pairs(keys) do
-- 	ngx.say(i .. "-> " .. j)
-- end

-- pattern = "^" .. pattern .. "$"

-- ngx.say(_M.is_match(_M.clear_slash("//todo/1/2"), pattern))

-- local params = _M.parse_path("/todo/1/2fsd", pattern, keys)
-- for i,j in pairs(params) do 
-- 	ngx.say("param:" .. i .. " " .. j)
-- end
