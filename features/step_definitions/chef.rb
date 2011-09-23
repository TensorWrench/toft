When /^I run "([^"]*)" on node "([^"]*)"$/ do |run_list, node|
  @controller.nodes[node].run_chef run_list
end

When /^I run recipes on node "([^"]*)":$/ do |node, recipes_table|
  recipes = []
  recipes_table.hashes.each do |row|
    recipes << row[:recipe]
  end
  @controller.nodes[node].run_chef recipes  
end

When /^I run "([^"]*)" on node "([^"]*)" and overwrite attributes with:$/ do |run_list, node, table|
  @controller.nodes[node].run_chef run_list, Tuft::ChefAttributes.new(table)
end

Then /^Node "([^"]*)" should have directory "([^"]*)"$/ do |node, dirpath|
  @controller.nodes[node].should have_dir(dirpath)
end

When /^I set the role path to empty$/ do
  Tuft.role_path = ""
  @controller.nodes['n1'].run_shell "rm -rf /tmp/*"
end

Then /^I run "([^"]*)" on node "([^"]*)" successfully$/ do |run_list, node|
  lambda { @controller.nodes[node].run_chef(run_list) }.should_not raise_error
end

When /^I set the cookbook path to empty$/ do
  Tuft.cookbook_path = ""
  @controller.nodes['n1'].run_shell "rm -rf /tmp/*"  
end

Then /^Running "([^"]*)" on node "([^"]*)" should fail$/ do |run_list, node|
  lambda { @controller.nodes[node].run_chef(run_list) }.should raise_error
end