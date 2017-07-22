require_relative "item"
require 'colorize'	
class List
	attr_accessor :items, :name
	def initialize (name, item = [])
		@name = name
		@items = item
	end

	#method add a new item
	def add(item)
		@items << item
	end

	#method complete an item
	def complete_at!(index)
		@items[index].done! 
	end
	
	# Method remove an item
	def remove_at!(index)
		@items.delete_at(index)
	end	
	
	# count the items
	def how_many_item?
		num = 0
		@items.each do |item|
		num = num + 1
		end	
		num
	end

	#display all items
	def display
		puts "------ #{name}--------".colorize(:blue) 
		@items.each_with_index do |item, index|
			if item.done?
				puts "- [X] #{item.name} (#{index +1})".colorize(:green) 
			else
				puts "- [ ] #{item.name} (#{index +1})".colorize(:red) 
			end
		end
	end

	#display the items done
	def display_done
		puts "welldone my boss, here is the items completed:".colorize(:blue) 
		@items.each do |item|
			if item.done?
				puts "- [X] #{item.name}".colorize(:green) 
			end
		end
	end
	#display the items undone
	def display_undone
		puts "Come on! Don't give up, here's these items we need to perfect it:".colorize(:blue) 
		@items.each do |item|
			if item.undone?
				puts "- [ ] #{item.name}".colorize(:red) 
			end
		end
	end	
end
