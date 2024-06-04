# Create a (Mutable) Struct BinarySearchTree, which has fields: data, left, right
# Three methods for accessing the fields have been provided to be used in testing
# Your BinarySearchTree should support the extra functionality seen in the tests


nodedata(tree::BinarySearchTree) = tree.data
rightnode(tree::BinarySearchTree) = tree.right
leftnode(tree::BinarySearchTree) = tree.left
