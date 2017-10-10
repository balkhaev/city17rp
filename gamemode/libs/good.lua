core.good = {}
core.good.store = {}

function core.good.getGood(goodType, goodEntity)
  if core.config.goods[goodType] == nil then return nil end

  for _, good in pairs(core.config.goods[goodType]) do
    if good.entity == goodEntity then
      return good
    end
  end
end
