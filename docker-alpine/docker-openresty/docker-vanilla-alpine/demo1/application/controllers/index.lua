local IndexController = {}

function IndexController:index()
    local view = self:getView()
    local p = {}
    p['vanilla'] = 'Welcome To Vanilla...'
    p['zhoujing'] = 'Power by Openresty by haisheng2222 111111111  222222222 333333333'
    view:assign(p)
    return view:display()
end

return IndexController
