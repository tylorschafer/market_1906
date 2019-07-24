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
end
