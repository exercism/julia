mutable struct BinarySearchTree
    data
    left
    right
    BinarySearchTree(node::T) where T<:Real = new(node, nothing, nothing)
end

function BinarySearchTree(vec::Vector{T}) where T<:Real
    tree = BinarySearchTree(popfirst!(vec))
    foreach(node -> push!(tree, node), vec)
    tree
end

function Base.in(node, tree::BinarySearchTree)
    tree.data == node && return true
    if node ≤ tree.data
        isnothing(tree.left) ? false : in(node, tree.left)
    else
        isnothing(tree.right) ? false : in(node, tree.right)
    end
end

function Base.push!(tree::BinarySearchTree, node)
    if node ≤ tree.data
        isnothing(tree.left) ? (tree.left = BinarySearchTree(node)) : push!(tree.left, node)
    else
        isnothing(tree.right) ? (tree.right = BinarySearchTree(node)) : push!(tree.right, node)
    end
    tree
end

function traverse(tree::BinarySearchTree, channel::Channel)
    !isnothing(tree.left) && traverse(tree.left, channel)
    put!(channel, tree.data)
    !isnothing(tree.right) && traverse(tree.right, channel)
end

Base.sort(tree::BinarySearchTree) = collect(Channel(channel -> traverse(tree, channel)))
