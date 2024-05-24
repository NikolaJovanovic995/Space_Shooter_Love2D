local classes = require("Scripts/Classes/classes")

local ObjectPool = classes.class()

function ObjectPool:init(params)
    self.objectClass = params.objectClass
    self.objectConfigs = params.objectConfigs
    self.pool = {}
end


function ObjectPool:spawn(objectType)
    if self.pool[objectType] == nil or #self.pool[objectType] == 0 then
        print("No objects in pool of type: " .. objectType)
        return self.objectClass.new(self.objectConfigs[objectType])
    else
        print("Get object from pool of type: " .. objectType)
        local object = table.remove(self.pool[objectType])
        object:reset(self.objectConfigs[objectType])
        return object
    end
end

function ObjectPool:despawn(object, objectType)
  
    if self.pool[objectType] == nil then
        print("Create new table in pool for objectType: " .. objectType)
        self.pool[objectType] = {}
    end
    
    print("Return object in pool for objectType: ".. objectType)
    table.insert(self.pool[objectType], object)
end


return ObjectPool