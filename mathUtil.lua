
function clamp(num, lower, upper)
    return math.max(lower, math.min(upper, num))
end

function calculateDistance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

function isColliding(x1, y1, r1, x2, y2, r2)    
  return calculateDistance(x1, y1, x2, y2) <= r1 + r2
end