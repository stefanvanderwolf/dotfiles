local module = {}

--- Clamp a number between min and max exclusive
---
--- @param n number
--- @param min number
--- @param max number
--- @return number
module.clamp = function(n, min, max)
    if n < min then return min end
    if n > max then return max end
    return n
end

return module
