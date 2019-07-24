require 'pry'

class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    @vendors.find_all {|vendor| vendor.check_stock(item) != 0}
  end

  def sorted_item_list
    @vendors.map {|vendor| vendor.inventory.keys}.flatten.uniq.sort
  end

  def total_inventory
    total_inventory = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        total_inventory[item] += quantity
      end
    end
    total_inventory
  end

  def sell(item, quantity)
    quantity_sold = quantity
    if total_inventory[item] > quantity_sold
      vendors_with_items = @vendors.find_all {|vendor| vendor.check_stock(item) != 0}
      vendors_with_items.each do |vendor|
        if quantity_sold == 0
          return true
        elsif vendor.check_stock(item) > quantity_sold
          vendor.inventory[item] -= quantity_sold
          return true
        elsif vendor.check_stock(item) < quantity_sold
          quantity_sold -= vendor.check_stock(item)
          vendor.inventory[item] = 0
        end
      end
    else
      return false
    end
  end
end
