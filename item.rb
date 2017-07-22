	class Item
    attr_accessor :mark, :title
    def initialize(task,done = false)
      @done = done
      @task = task
    end
    # an instance??? I Dont know much about it
    def self.new_from_line(line)
      task = line[6..-1]
      done = line[3] == "X"
      Item.new(task, done)
    end
	# Method undone : is the task completed?
    def done?
      @done 
    end
		def done!
      @done = true
    end
	# Method undone : is the task not completed?
    def undone?
      !done?
    end

	#	def label_status
	#		done? ? "Done" : "Not Done"
	#	end 	
	# Method complete status : check in the task -> complete
  #  def complete_at!
  #    mark = "+"
  #  end
    def name
			@task
    end    

    #def self.count
    #  all.count
    #end
end
