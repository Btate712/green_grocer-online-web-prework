require 'pry'

def consolidate_cart(cart)
	return_hash = {}
  cart.each do |item|
		item.each do |key, values|
      return_hash[key] = {}
      return_hash[key][:price] = values[:price]
      return_hash[key][:clearance] = values[:clearance]
      return_hash[key][:count] = cart.count(item)
    end
	end
  return_hash
end

def apply_coupons(cart, coupons)
  #fix me
  coupons.each do |coupon|
    new_item_name = ""
    new_item_hash = {}
    cart.each do |item, info|
      if item == coupon[:item] && info[:count] >= coupon[:num]
        new_item_name = "#{coupon[:item]} W/COUPON"
        info[:count] -= coupon[:num]
        new_item_hash[:price] = coupon[:cost]
        new_item_hash[:clearance] = info[:clearance]
        new_item_hash[:count] = 1
      end
    end
		#check for existing item of same name:
		binding.pry
    cart[new_item_name] = new_item_hash
  end

	cart
end


def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
