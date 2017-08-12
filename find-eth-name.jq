#!/usr/bin/jq -rf

# lshw -json | $0

def f:
  if type == "object"
  then if has("children") then .children
     elif has("class") and .class == "network" then .
     elif has("ethernet") and .ethernet == true then .
     else empty end
  else . end;

walk(f) | flatten | .[]
    | .capabilities += { logicalname } | .capabilities
    | select(has("100bt")) | .logicalname
