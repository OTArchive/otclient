# lua5.1
lua 5.1 source code

add lfs to lualib

```lua
package.loaded['lfs'] = lfs
local lfs = require("lfs")
```
