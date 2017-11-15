class LunchGrouper
  MIN_GROUP_SIZE = 3
  def initialize(seed: seed)
    @seed = seed.to_i
    @employees = Employee.order(:id).all #if this gets more complicated, extract w/ a wrapper around A.R.
    @grouped_employees = []
  end

  def group_employees
    grouped_employees = shuffled_employees.in_groups_of(MIN_GROUP_SIZE, false)
    #check to make sure we have at least 3 people to match
    return [] unless at_least_one_group?(grouped_employees)

    if grouped_employees.last.length < 3
      grouped_employees = back_populate_extras(grouped_employees)
    end

    return grouped_employees
  end

  def save!
    if lunch_group = LunchGroupCreateService.new(seed: @seed, groups: group_employees).perform!
      #LunchMailer.send_lunch_notifications(@grouped_employees)
      return lunch_group
    else
      false
    end
  end

  private
    def at_least_one_group?(grouped_employees)
      return false unless grouped_employees #nil
      return false if grouped_employees.length.zero? #no groups
      return false unless grouped_employees.first.length >= MIN_GROUP_SIZE #at least 1 group
    
      true
    end

    def back_populate_extras(lunch_groups)
      groups = lunch_groups
      last_group = groups.pop
      last_index = groups.length - 1
      last_group.each_with_index do |extra_member, i|
        groups[last_index - i] << extra_member
      end

      return groups
    end

    def shuffled_employees
      @employees.shuffle(random: Random.new(@seed))
    end

end