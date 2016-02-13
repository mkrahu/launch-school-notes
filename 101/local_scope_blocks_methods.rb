# scope_blocks_methods.rb

# Notes about Ruby local scope within blocks and methods

# 1. A variable's scope determines where in the program it is available for use
# 2. A variable's scope is determined by where in the program it is initialised or created
# 3. In Ruby, a variable's scope is defined by a block
# 4. The outermost scope of the program (outside any blocks or method definitions) is the top level scope
# 5. Scope can bleed through blocks from out to in
#   - a variable initialised outside a block IS available inside the block
#   - a variable initialised inside a block IS NOT avaialble outside the block
