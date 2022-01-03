--- data format transformation related functions
-- @module transform
-- @author Potulski Dirk , Garge Shekhar, Sangeeth Kumar

local transform = {}

--- Transforms given valid json string to Lua table
-- @tparam      {string}  s  (mandatory) json string
-- @treturn     {table}      Lua table in case of success; nil in case of failure or invalid input
function transform:jsonToLua(s)
  local t = json2Lua(s)
  return t
end

--- Transforms given Lua table to json string
-- @tparam      {table}  t   (mandatory) Lua table
-- @treturn     {string}     json string in case of success; nil in case of failure or invalid input
function transform:luaToJson(t)
  local s = lua2Json(t)
  return s
end

return transform