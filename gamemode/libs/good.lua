core.good = {}
core.good.store = {}
core.good.uniqIndex = 0

function core.good.addGood(goodType, good)
  local goodEnt = ents.Create(good.entity)

  if not IsValid(goodEnt) then return end

  core.good.uniqIndex = core.good.uniqIndex + 1

  core.good.store[core.good.uniqIndex] = {
    entity = good.entity,
    title = good.title,
    cost = good.cost,
    type = goodType,
    model = goodEnt:GetModel()
  }

  return core.good.uniqIndex
end

function core.good.getGoods()
  return core.good.store
end

function core.good.getGood(goodType, goodEntity)
  if core.config.goods[goodType] == nil then return nil end

  for _, good in pairs(core.good.store) do
    if good.entity == goodEntity then
      return good
    end
  end
end

function core.good.getGoodsByType(goodType)
  local out = {}

  for index, good in pairs(core.good.store) do
    if good.type == goodType then out[index] = good end
  end

  return out
end
