class LunchGroupCreateService

  def initialize(seed: seed, groups: groups)
    @seed = seed
    @groups = groups
  end

  def perform!
    return false if @groups.empty?
    
    lunch_group = LunchGroup.create(seed: @seed)
    
    @groups.each do |group|
      #create a parent grouping
      grouping = lunch_group.groupings.new
      #create a grouping employee to point to each employee via "join_table"
      group.each do |employee|
        grouping.grouping_employees.new(employee: employee)
      end
    end

    return lunch_group if lunch_group.save
  end
  
end