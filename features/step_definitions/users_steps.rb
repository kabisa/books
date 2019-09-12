Given("the following users:") do |table|
  table.hashes.each do |h|
    create(:user, h)
  end
end
