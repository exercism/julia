mutable struct BinarySearchTree
    data
    left
    right
    BinarySearchTree() = new(nothing, nothing, nothing)
    BinarySearchTree(node::T) where T<:Real = new(node, nothing, nothing) 
end

function BinarySearchTree(vector::Vector{T}) where T<:Real
    tree = BinarySearchTree()
    foreach(node -> push!(tree, node), vector)
    tree
end

nodedata(tree::BinarySearchTree) = tree.data
rightnode(tree::BinarySearchTree) = tree.right
leftnode(tree::BinarySearchTree) = tree.left

function Base.in(node, tree::BinarySearchTree,)
    nodedata(tree) == node && return true
    if node ≤ nodedata(tree)
        isnothing(leftnode(tree)) ? false : in(node, leftnode(tree))
    else
        isnothing(rightnode(tree)) ? false : in(node, rightnode(tree))
    end
end

function Base.push!(tree::BinarySearchTree, node::T) where T<:Real
    if isnothing(nodedata(tree))
        tree.data = node
    elseif node ≤ nodedata(tree)
        isnothing(leftnode(tree)) ? (tree.left = BinarySearchTree(node)) : push!(leftnode(tree), node)
    else
        isnothing(rightnode(tree)) ? (tree.right = BinarySearchTree(node)) : push!(rightnode(tree), node)
    end
    tree
end

function Base.append!(tree::BinarySearchTree, vector::Vector{T}) where T<:Real
    foreach(node -> push!(tree, node), vector)
    tree
end

function traverse(tree::BinarySearchTree, channel::Channel)
    !isnothing(leftnode(tree)) && traverse(leftnode(tree), channel)
    put!(channel, nodedata(tree))
    !isnothing(rightnode(tree)) && traverse(rightnode(tree), channel)
end

Base.sort(tree::BinarySearchTree) = collect(Channel(channel -> traverse(tree, channel)))
