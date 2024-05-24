local MathUtil = {}

MathUtil.clamp = function(num, lower, upper)
    return math.max(lower, math.min(upper, num))
end

MathUtil.calculateDistance = function (x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

MathUtil.isColliding = function (x1, y1, offsetX1, offsetY1, x2, y2, offsetX2, offsetY2)
    --is left side of either farther to the right than the right side of the other
    if x1 - offsetX1 > x2 + offsetX2 or x2 - offsetX2 > x1 + offsetX1 then
        return false
    end
    
    --is bottom side of either higher than the top side of the other
    if y1 + offsetY1 < y2 - offsetY2 or y2 + offsetY2 < y1 - offsetY1 then
        return false
    end
    
    return true
end

return MathUtil