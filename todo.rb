require 'fileutils'
require_relative "item"
require_relative "list"
require 'colorize'	
	class Todo
		# attr_accessor :lines, :list
		def initialize (filename = "todo.data")
			@filename = filename
			@list = List.new("Today")
			
		end
		# Show all items
		def show_all
			puts "here is our mission today:".colorize(:blue) 
			@list.display
		end

		# The current list
		def list
			@list
		end	
		
		# Show the number of items
		#first way
		def number_item 
			 @list.how_many_item? 	
		end
		#second way
		#def number_item 
		#	Item.count	
		#end

		# Show all done items
		def show_done
			@list.display_done
		end
		
		# Show all undone items
		def show_undone
			@list.display_undone
		end	
		
		# Add an item
		def add(task)
			item = Item.new(task)
			@list.add(item)
			show_all
		end	
		
		# Loading... file
		def load_data
			@lines = File.read(@filename).split("\n")
			@lines.each do |line|
			# "- [ ] Learn Numbers"
			item = Item.new_from_line(line)
			@list.add(item)
			end	
		end	

		# Item completed
		def mark_item(index)
			mark_index = index
			loop do 
				break if mark_index <= number_item 
				show_all
				puts "Enter the right item number to mark as done:".colorize(:red) 
				grandma_index = gets.chomp.split
				grandma_index[0]
				mark_index = grandma_index[0].to_i
			end
			puts "You've marked index #{mark_index} as done".colorize(:blue) 
			@list.complete_at!(mark_index - 1)
			show_all
			puts "Great bro, the task is complete!".colorize(:blue) 
		end	
		
		#remove an item
		def remove_item(index)
			re_index = index
			loop do 
				break if re_index <= number_item 
				show_all
				puts "Enter the right item number to remove:".colorize(:red) 
				grandma_index = gets.chomp.split
				grandma_index[0]
				re_index = grandma_index[0].to_i
			end
			puts "the item has been removed".colorize(:blue) 
			@list.remove_at!(re_index - 1)
			show_all
			puts "the task is remove!"
		end
		# Have fun with prompt
		def start_prompt
			puts "your commands your rules:".colorize(:blue) 
			grandma_index = gets.chomp.split
			case grandma_index[0]
			when "exit", "e", "quit"  
				puts "---------------Goodbye!----------------".colorize(:blue) 
					"exit"	
			when "showall","list","sa", "all"
				show_all
			when "add","a", "+"
				add(grandma_index[1..-1].join(" "))				
			when "showdone", "sd", "done"
				show_done
			when "showundone", "su", "undone"
				show_undone
			when "mark", "m"
				mark_item(grandma_index[1].to_i)
			when "num" 
				puts "number items: #{number_item}".colorize(:green) 	
			when "r", "remove" 
				remove_item((grandma_index[1].to_i))	
			else	 
				display_instructions
			end
		end		
		def display_instructions
			puts "----------------------------------------------------".colorize(:blue) 
    	puts "Here are the commands you can try:".colorize(:red)
    	puts "- showall".colorize(:red) + ", ".colorize(:blue) + "all".colorize(:red) + ", ".colorize(:blue) + "sa".colorize(:red) + " or".colorize(:blue) + " list".colorize(:red) + "   : show all items".colorize(:blue)
    	puts "- done".colorize(:red) + ",".colorize(:blue) + " showdone".colorize(:red) + " or".colorize(:blue) + " sd".colorize(:red) + "       : show done items".colorize(:blue)
			puts "- undone".colorize(:red) + ",".colorize(:blue) + " showundone".colorize(:red) + " or".colorize(:blue) + " su".colorize(:red) + "   : show done items".colorize(:blue)
			puts "- add".colorize(:red) + " item".colorize(:green) + ",".colorize(:blue) + " a".colorize(:red) + " item".colorize(:green) + " or".colorize(:blue) + " +".colorize(:red) + " item".colorize(:green) + " : add a new task".colorize(:blue)
			puts "- remove".colorize(:red) + " index ".colorize(:green) + "or ".colorize(:blue) + "r ".colorize(:red) + "index".colorize(:green) + "    : remove a task".colorize(:blue)
			puts "- mark".colorize(:red) + " index".colorize(:green)  + " or".colorize(:blue)  + " m".colorize(:red) + " index".colorize(:green)  + "      : mark a task as done".colorize(:blue)
			puts "- num".colorize(:red) + "                        : give number of items".colorize(:blue)
			puts "- exit".colorize(:red) + ",".colorize(:blue)  + "quit".colorize(:red) + " or".colorize(:blue)  + " e".colorize(:red) + "             : Quit the application".colorize(:blue)
			
		end
	end   
	@todo = Todo.new
	@todo.list
	@todo.load_data
	puts "-----------welcome to todo App-----------".rjust(50).colorize(:blue) 
	case ARGV[0]   
	when "showall", "list", "sa", "all"
		@todo.show_all
	when "add","a", "+"
		@todo.add(ARGV[1..-1].join(" "))				
	when "showdone", "sd", "done"
		@todo.show_done
	when "showundone", "su", "undone"
		@todo.show_undone
	when "num" 
		Puts "number items: #{@todo.number_item}"		
	else	 
			ARGV.clear
			@todo.display_instructions
		loop do	
			break if @todo.start_prompt == "exit"
		end	
	end
	
