
local MESSAGE_BOX =
{
    "Es Y'Golonac",
    "Es Y'Golonac",
    "Es Y'Golonac",
    "Monstro con las bocas en sus manos",
    "",
    "Es Y'Golonac",
    "Es Y'Golonac",
    "Es Y'Golonac",
    "Monstro con las bocas en sus manos",
    "",
    "On his hands he's got orifices",
    "Oh on his hands he's got orifices",
    "On his hands he's got orifices",
    "And he hasn't got a head!",
    "",
    "Yes on his hands he's got orifices",
    "Oh on his hands he's got orifices",
    "Oh on his hands he's got orifices",
    "And he hasn't got a head!",
}

local Chatterbox = Class(function(self, inst)
    self.inst = inst
    
    self.index = 1
    
    local interval = 1
    self.task = inst:DoPeriodicTask(interval, function()
        --print("KK-TEST> Executing server-side periodic task!")
        self:Sing()
    end, 1)
    
    inst:AddTag("chatterbox")
end)

local function Say(inst, msg)
    --print("KK-TEST> inst.replica.chatterbox.line:set("..msg..")")
    inst.replica.chatterbox.line:set(msg)
end

function Chatterbox:Sing()
    local msg = MESSAGE_BOX[self.index]
    self.index = self.index + 1
    if self.index > #MESSAGE_BOX then
        self.index = 1
    end
    if msg ~= nil then
        Say(self.inst, msg)
    end
end

function Chatterbox:OnRemoveFromEntity()
    self.inst:RemoveTag("chatterbox")
    
    if self.task ~= nil then
        self.task:Cleanup()
        self.task = nil
    end
end

return Chatterbox