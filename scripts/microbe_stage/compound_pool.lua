-- Compound pool

class 'CompoundPool'

function CompoundPool:__init(pool)
	if pool == nil then self.compounds = {} else self.compounds = pool end
end

-- returns min(amount, self.compounds[compound]), decrementing contents by amount returned
function CompoundPool:takeCompound(compound, amount)
	if type(compound) == "string" then compound = CompoundRegistry.getCompoundId(compound) end
	if self.compounds[compound] == nil then return 0 end
	out = math.min(amount, self.compounds[compound])
	self.compounds[compound] = self.compounds[compound] - out
	return out
end

function CompoundPool:giveCompound(compound, amount)
	if type(compound) == "string" then compound = CompoundRegistry.getCompoundId(compound) end
	self.compounds[compound] = self.compounds[compound] + amount
end

-- the above two nonconserving functions should be called only from processes

-- conserves mass
function CompoundPool:transferTo(target, compound, amount)
	amount = self:takeCompound(compound, amount)
	target:giveCompound(compound, amount)
end
