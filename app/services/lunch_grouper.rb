class LunchGrouper
  MIN_GROUP_SIZE = 3
  def initialize(seed: seed)
    @seed = seed
    @employees = Employee.order(:id).all #if this gets more complicated, extract w/ a wrapper around A.R.
    @group_employees = []
  end

  def group_employees
    @grouped_employees = shuffled_employees.in_groups_of(3, false)
    lunch_groups = []

    #check to make sure we have at least 3 people to match
    return lunch_groups unless at_least_one_group?(@grouped_employees)

    @grouped_employees.each_with_index do |group, i|
      #check to make sure they have >=3
      if group.length < 3
        #if they're short, sprinkle the extras into random groups
        back_populate_extras(lunch_groups, group)
      else
        #otherwise, this is a valid group of 3, add it to the list
        lunch_groups << group
      end
    end

    lunch_groups
  end

  def save!
    #this is wrong-ish, because if you add an employee after creating it, the order will be off
    lunch_group = LunchGroup.create(seed: @seed)
    #LunchMailer.send_lunch_notifications(@grouped_employees)

    lunch_group
  end

  private
    def at_least_one_group?(grouped_employees)
      return false unless grouped_employees #nil
      return false if grouped_employees.length.zero? #no groups
      return false unless grouped_employees.first.length >= MIN_GROUP_SIZE #at least 1 group
    
      true
    end

    def back_populate_extras(lunch_groups, group)
      last_index = lunch_groups.length - 1
      group.each_with_index do |extra_member, i|
        lunch_groups[last_index - i] << extra_member
      end
    end

    def shuffled_employees
      @employees.shuffle(random: Random.new(@seed))
    end

end