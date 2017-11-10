class LunchGrouper
  MIN_GROUP_SIZE = 3
  def initialize(seed: seed)
    @seed = seed
    @employees = Employee.all #if this gets more complicated, extract w/ a wrapper around A.R.
    @group_employees = []
  end

  def group_employees
    @grouped_employees = shuffled_employees.in_groups_of(3, false)
    lunch_groups = []

    #check to make sure we have at least 3 people to match
    return lunch_groups unless at_least_one_group?(grouped_employees)

    grouped_employees.each_with_index do |group, i|
      #check to make sure they have >=3
      if group.length < 3
        #if they're short, stick the small group with the previous group
        lunch_groups[i-1].push(*group) #splat so its a single array
      else
        lunch_groups << group
      end
    end

    lunch_groups
  end

  def save!(seed: seed)
    #LunchGroup.create(seed: seed, employees: @grouped_employees)
    #LunchMailer.send_lunch_notifications(@grouped_employees)
  end

  private
    def at_least_one_group?(grouped_employees)
      return false unless grouped_employees #nil
      return false if grouped_employees.length.zero? #no groups
      return false unless grouped_employees.first.length >= MIN_GROUP_SIZE #at least 1 group
    
      true
    end

    def shuffled_employees
      @employees.shuffle(random: Random.new(@seed))
    end

end