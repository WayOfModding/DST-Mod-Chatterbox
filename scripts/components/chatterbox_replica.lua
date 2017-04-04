local function Say(inst, msg)
    --print("KK-TEST> inst.components.talker:Say("..msg..")")
    inst.components.talker:Say(msg)
end

local Chatterbox = Class(function(self, inst)
    self.inst = inst
    
    self.line = net_string(inst.GUID, "chatterbox.line", "chatterboxdirty")
    
    local interval = 1
    self.task = inst:DoPeriodicTask(interval, function()
        --print("KK-TEST> Executing client-side periodic task!")
        self:Sing()
    end, 1)
    
    if not TheWorld.ismastersim then
        self.OnChatterboxDirty = function(inst)
            --print("Event 'chatterboxdirty':", tostring(self.line:value()))
        end
        
        inst:ListenForEvent("chatterboxdirty", self.OnChatterboxDirty)
    end
end)

function Chatterbox:Sing()
    Say(self.inst, self.line:value())
end

function Chatterbox:OnRemoveFromEntity()
    if not TheWorld.ismastersim then
        self:RemoveEventCallback("chatterboxdirty", self.OnChatterboxDirty)
    end
    
    if self.task ~= nil then
        self.task:Cleanup()
        self.task = nil
    end
end


return Chatterbox