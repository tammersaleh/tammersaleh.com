# Read more: http://pivotallabs.com/users/zach/blog/articles/906-an-easy-way-to-write-named-scope-tests

def assert_named_scope(all_objects, subset, &condition)
  scoped_objects, other_objects = all_objects.partition(&condition)
  
  assert !scoped_objects.empty?, "No records matched the named scope."
  assert !other_objects.empty?, "All objects matched the named scope."
  assert_equal scoped_objects, subset, "The records returned from the named scope didn't match what you expected."

  assert_equal other_objects, all_objects - subset, "Some expected records were missing from the result of the named scope."
end


