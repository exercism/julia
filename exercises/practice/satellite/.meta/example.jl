struct Tree
    root::String
    left::Union{Tree, Nothing}
    right::Union{Tree, Nothing}
end

function tree_from_traversals(preorder, inorder)
    length(preorder) == length(inorder) || 
        throw(ArgumentError("traversals must have the same length"))

    sort(preorder) == sort(inorder) || 
        throw(ArgumentError("traversals must have the same elements"))

    length(preorder) == length(unique(preorder)) || 
        throw(ArgumentError("traversals must contain unique items"))

    tree(preorder, inorder)
end

function tree(preorder, inorder)
    isempty(preorder) && return(nothing)

    root = preorder[1]
    inx = findfirst(==(root), inorder)
    left = tree(preorder[2:inx], inorder[1:inx - 1])
    right = tree(preorder[inx + 1:end], inorder[inx + 1:end])
    Tree(root, left, right)
end
