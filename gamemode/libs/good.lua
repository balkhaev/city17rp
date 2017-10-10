core.good = {}

function core.good.getGood(entityType, entityName)
  if core.config.goods[entityType] == nil then return nil end

  for _, good in pairs(core.config.goods[entityType]) do
    if good.entity == entityName then
      return good
    end
  end
end